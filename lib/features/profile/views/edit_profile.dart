  import 'dart:io';
  import 'package:caffeine/core/constants/app_colors.dart';
  import 'package:caffeine/core/helpers/spacing.dart';
  import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
  import 'package:caffeine/features/profile/cubit/user_data_state.dart';
import 'package:caffeine/features/profile/widgets/input_feild.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
  import 'package:image_picker/image_picker.dart';

  
  class EditProfileView extends StatefulWidget {
    const EditProfileView({super.key});
  
    @override
    State<EditProfileView> createState() => _EditProfileViewState();
  }
  
  class _EditProfileViewState extends State<EditProfileView> {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    XFile? _selectedImage;
    String? _currentImageUrl;
  
    @override
    void initState() {
      super.initState();
      // Fetch current user data
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserDataCubit>().fetchUserData();
      });
    }
  
    @override
    void dispose() {
      _nameController.dispose();
      _emailController.dispose();
      super.dispose();
    }
  
  
    Widget build(BuildContext context) {
      return BlocListener<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if (state is UserDataSuccess) {
              _nameController.text = state.userData.name;
              _emailController.text = state.userData.email;
              _currentImageUrl = state.userData.imageUrl;
              if (_selectedImage != null) return;
          } else if (state is ImagePicking) {
            // _isLoading = true;
          } else if (state is ImagePicked) {
              _selectedImage = XFile(state.localPath);
          } else if (state is ImageUploaded) {
              _currentImageUrl = state.image;
    
          } else if (state is ProfileUpdateSuccess) {
            context.read<UserDataCubit>().fetchUserData();
            context.pop();
      } else if (state is UserDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } 
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryColor.withOpacity(.5),
                  AppColors.secondaryColor.withOpacity(.3),
                  Colors.white.withOpacity(.4),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                        ),
                        Expanded(
                          child: Text(
                            'Edit Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 48.w), // Balance the back button
                      ],
                    ),
                  ),
  
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Spacing.vSpace(20.h),
  
                          // Profile Image
                          BlocBuilder<UserDataCubit, UserDataState>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 120.w,
                                    height: 120.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor.withOpacity(
                                            .3,
                                          ),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: _selectedImage != null
                                          ? Image.file(
                                              File(_selectedImage!.path),
                                              fit: BoxFit.cover,
                                            )
                                          : (_currentImageUrl != null &&
                                                  _currentImageUrl!.isNotEmpty)
                                              ? Image.network(
                                                  _currentImageUrl!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 60.sp,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Image.asset(
                                                  'assets/pnga/profile.png',
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey[200],
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 60.sp,
                                                            color:
                                                                AppColors.primaryColor,
                                                          ),
                                                        );
                                                      },
                                                ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // This will pick and upload (cubit emits states for preview & upload)
                                        context.read<UserDataCubit>().uploadImageToCloudinary();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
  
                          Spacing.vSpace(40.h),
  
                          InputField(
                            label: 'Full Name',
                            controller: _nameController,
                            icon: Icons.person_outline,
                            hint: 'Enter your name',
                          ),
  
                          Spacing.vSpace(20.h),
  
                          InputField(
                            label: 'Email',
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            hint: 'Email',
                            readOnly: true,
                            suffixIcon: Icon(
                              Icons.lock_outline,
                              size: 20.sp,
                              color: Colors.grey,
                            ),
                          ),
  
                          Spacing.vSpace(50.h),
  
                          GestureDetector(
                            onTap: () {
                                    final state = context.read<UserDataCubit>().state;
                                    String imageUrlToSend = '';
                                    if (state is ImageUploaded) {
                                      imageUrlToSend = state.image;
                                    } else if (_currentImageUrl != null && _currentImageUrl!.isNotEmpty) {
                                      imageUrlToSend = _currentImageUrl!;
                                    } else {
                                      imageUrlToSend = '';
                                    }
  
                                    context.read<UserDataCubit>().updateProfile(
                                          name: _nameController.text.trim(),
                                          imageUrl: imageUrlToSend,
                                        );
  
                                  },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryColor,
                                    AppColors.primaryColor.withOpacity(.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(
                                      .3,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Text(
                                      'Save Changes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
  
                          Spacing.vSpace(40.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
  
  
  

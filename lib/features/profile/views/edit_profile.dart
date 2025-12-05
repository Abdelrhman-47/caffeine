  import 'dart:io';
  import 'package:caffeine/core/constants/app_colors.dart';
  import 'package:caffeine/core/helpers/spacing.dart';
  import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
  import 'package:caffeine/features/profile/cubit/user_data_state.dart';
import 'package:caffeine/features/profile/views/profile_view.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:image_picker/image_picker.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/utils/di_helpers.dart';
  
  class EditProfileView extends StatefulWidget {
    const EditProfileView({super.key});
  
    @override
    State<EditProfileView> createState() => _EditProfileViewState();
  }
  
  class _EditProfileViewState extends State<EditProfileView> {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    XFile? _selectedImage;
    bool _isLoading = false;
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
            _isLoading = true;
          } else if (state is ImagePicked) {
            // Show picked local image immediately
              _selectedImage = XFile(state.localPath);
              _isLoading = false;
          } else if (state is ImageUploaded) {
            // Update current image URL with uploaded URL
              _currentImageUrl = state.image;
              _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image uploaded successfully')),
            );
          } else if (state is ProfileUpdateSuccess) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            context.read<UserDataCubit>().fetchUserData();
            Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => getIt<UserDataCubit>(),
  child: ProfileView(),
)))    ;      } else if (state is UserDataFailure) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ImageSelectionCancelled) {
             _isLoading = false;
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
  
                          // Name Field
                          _InputField(
                            label: 'Full Name',
                            controller: _nameController,
                            icon: Icons.person_outline,
                            hint: 'Enter your name',
                          ),
  
                          Spacing.vSpace(20.h),
  
                          // Email Field (Read-only)
                          _InputField(
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
  
                          // Save Button (always visible)
                          GestureDetector(
                            onTap: _isLoading
                                ? null
                                : () {
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
  
                                    setState(() => _isLoading = true);
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
                              child: _isLoading
                                  ? Center(
                                      child: SizedBox(
                                        width: 24.w,
                                        height: 24.h,
                                        child:
                                            const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                      ),
                                    )
                                  : Text(
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
  
  class _InputField extends StatelessWidget {
    final String label;
    final TextEditingController controller;
    final IconData icon;
    final String hint;
    final bool readOnly;
    final Widget? suffixIcon;
  
    const _InputField({
      required this.label,
      required this.controller,
      required this.icon,
      required this.hint,
      this.readOnly = false,
      this.suffixIcon,
    });
  
    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Spacing.vSpace(10.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              style: TextStyle(
                fontSize: 16.sp,
                color: readOnly ? Colors.grey : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(
                  icon,
                  color: AppColors.primaryColor.withOpacity(.7),
                  size: 22.sp,
                ),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: readOnly ? Colors.grey[50] : Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
  
  class _ImageSourceOption extends StatelessWidget {
    final IconData icon;
    final String label;
    final VoidCallback onTap;
  
    const _ImageSourceOption({
      required this.icon,
      required this.label,
      required this.onTap,
    });
  
    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.primaryColor.withOpacity(.2)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40.sp, color: AppColors.primaryColor),
              Spacing.vSpace(8.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

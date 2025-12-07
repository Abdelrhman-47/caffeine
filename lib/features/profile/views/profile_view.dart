import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/views/edit_profile.dart';
import 'package:caffeine/features/profile/widgets/menu_item.dart';
import 'package:caffeine/features/profile/widgets/profile_inf.dart';
import 'package:caffeine/features/profile/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    context.read<UserDataCubit>().fetchUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                    ),
                    Spacing.hSpace(75.w),

                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),

                Spacing.vSpace(20.h),

                // Profile Image
                ProfileInf(),
                Spacing.vSpace(25.h),

                // Stats Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(
                      icon: Icons.shopping_bag,
                      value: '24',
                      label: 'Orders',
                    ),
                    StatCard(
                      icon: Icons.favorite,
                      value: '12',
                      label: 'Favorites',
                    ),
                    StatCard(icon: Icons.star, value: '450', label: 'Points'),
                  ],
                ),

                Spacing.vSpace(30.h),

                // Menu Items
                MenuItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => getIt<UserDataCubit>(),
                          child: const EditProfileView(),
                        ),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'My Addresses',
                  onTap: () {},
                ),
                MenuItem(
                  icon: Icons.receipt_long_outlined,
                  title: 'Order History',
                  onTap: () {},
                ),
                MenuItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () {},
                ),
                MenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primaryColor,
                  ),
                ),
                MenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                MenuItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {},
                ),

                Spacing.vSpace(20.h),

                // Logout Button
                GestureDetector(
                  onTap: () {},
                  child: GlassContainer(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    color: Colors.red.withOpacity(.1),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.red.withOpacity(.3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red, size: 22.sp),
                        Spacing.hSpace(10.w),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Spacing.vSpace(100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


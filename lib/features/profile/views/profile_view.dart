import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/views/edit_profile.dart';
import 'package:caffeine/features/profile/widgets/profile_inf.dart';
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
                    _StatCard(
                      icon: Icons.shopping_bag,
                      value: '24',
                      label: 'Orders',
                    ),
                    _StatCard(
                      icon: Icons.favorite,
                      value: '12',
                      label: 'Favorites',
                    ),
                    _StatCard(icon: Icons.star, value: '450', label: 'Points'),
                  ],
                ),

                Spacing.vSpace(30.h),

                // Menu Items
                _MenuItem(
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
                _MenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'My Addresses',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.receipt_long_outlined,
                  title: 'Order History',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primaryColor,
                  ),
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                _MenuItem(
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      color: AppColors.primaryColor.withOpacity(.1),
      borderRadius: BorderRadius.circular(15.r),
      border: Border.all(color: AppColors.primaryColor.withOpacity(.2)),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28.sp),
          Spacing.vSpace(8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
            ),
            Spacing.hSpace(15.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            trailing ??
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

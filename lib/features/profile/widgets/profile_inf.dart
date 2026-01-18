import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/cubit/user_data_state.dart';
import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInf extends StatelessWidget {
  const ProfileInf({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserDataCubit>().fetchUserData();
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataFailure ) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserDataSuccess ) {
          final UserData userData = state.userData;
       return   Column(
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: userData.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 60.sp,
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),

            Spacing.vSpace(15.h),

            // User Name
            Text(
              userData.name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            Spacing.vSpace(5.h),

            // Email
            Text(
              userData.email,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ],
        );

        }
        return SizedBox.shrink();
      },
    );
  }
}

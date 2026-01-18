import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/constants/text_style.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActionsButton extends StatelessWidget {
  const ActionsButton({
    super.key,
    required this.onPressedLogin,
    required this.onPressedSignUp,
    required this.onPressedGuest,
  });
  final void Function() onPressedLogin;
  final void Function() onPressedSignUp;
  final void Function() onPressedGuest;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.goNamed(AppRoutes.homeLayout);
            }
            if (state is AuthFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    title: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    content: Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                    ),
                    actions: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Try Again',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },

          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return CustomButton(
                backgroundColor: AppColors.buttonColor,
                text: 'Log In',
                onPressed: onPressedLogin,
                textColor: Colors.white,
                height: 44.h,
                width: 400.w,
                textStyle: TextStyle(fontSize: 15.sp),
                borderRadius: BorderRadius.circular(11.r),
                outLineButton: false,
                isLoading: isLoading,
              );
            },
          ),
        ),

        Spacing.vSpace(10),
        Row(
          children: [
            CustomButton(
              text: 'Sign up',
              onPressed: onPressedSignUp,
              textColor: AppColors.secondaryColor,
              height: 44.h,
              width: 130.w,
              textStyle: AppStyle.signUpStyle,

              borderRadius: BorderRadius.circular(15.r),
              outLineButton: true,
            ),
            Spacer(),
            CustomButton(
              text: 'Guest',
              onPressed: onPressedGuest,
              textColor: AppColors.secondaryColor,
              height: 44.h,
              width: 130.w,
              textStyle: AppStyle.signUpStyle,
              borderRadius: BorderRadius.circular(15.r),
              outLineButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

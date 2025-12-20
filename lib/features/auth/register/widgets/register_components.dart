import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/core/sheared_widgets/custom_form_feild.dart';
import 'package:caffeine/core/utils/validator.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/cubit/auth_state.dart';
import 'package:caffeine/features/auth/register/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterComponents extends StatefulWidget {
  const RegisterComponents({super.key});

  @override
  State<RegisterComponents> createState() => _RegisterComponentsState();
}

class _RegisterComponentsState extends State<RegisterComponents> {
  final TextEditingController _password = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _password.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        children: [
          Spacing.vSpace(10.h),
          CustomTxtfield(
            hint: 'user name',
            isPassword: false,
            controller: _name,
            validator: (v) {
              return AppValidators.displayNamevalidator(v);
            },
          ),
          Spacing.vSpace(5.h),
          CustomTxtfield(
            hint: 'enter your email',
            isPassword: false,
            controller: _email,
            validator: (v) {
              return AppValidators.emailValidator(v);
            },
          ),
          Spacing.vSpace(5.h),
          CustomTxtfield(
            hint: 'creat a password',
            isPassword: true,
            controller: _password,
            validator: (v) {
              return AppValidators.passwordValidator(v);
            },
          ),
          Spacing.vSpace(4.h),
          CustomTxtfield(
            hint: 'confirm password',
            isPassword: true,
            controller: TextEditingController(),
            validator: (v) {
              return AppValidators.passwordValidator(v);
            },
          ),
          Spacing.vSpace(4.h),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      title: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50.sp,
                      ),
                      content: Text(
                        state.error,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),
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
              if (state is AuthSuccess) {
                context.pushReplacementNamed(AppRoutes.homeLayout);
              }
            },

            child: CustomButton(
              backgroundColor: AppColors.buttonColor,
              text: 'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().signUp(
                    email: _email.text.trim(),
                    password: _password.text,
                    name: _name.text,
                    url: '',
                  );
                }
              },
              textColor: Colors.white,
              height: 40.h,
              width: 400.w,
              textStyle: TextStyle(fontSize: 15.sp),
              borderRadius: BorderRadius.circular(8.r),
              outLineButton: false,
            ),
          ),
          Spacing.vSpace(1.h),
          CustomRichText(),
        ],
      ),
    );
  }
}

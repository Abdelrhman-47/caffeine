import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_form_feild.dart';
import 'package:caffeine/core/utils/validator.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/login/widgets/actions_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginComponents extends StatefulWidget {
  const LoginComponents({super.key});

  @override
  State<LoginComponents> createState() => _LoginComponentsState();
}

class _LoginComponentsState extends State<LoginComponents> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            Spacing.vSpace(40.h),
            CustomTxtfield(
              validator: (v) =>
                  AppValidators.emailValidator(_emailController.text),
              hint: ' enter your email',
              isPassword: false,
              controller: _emailController,
            ),
            Spacing.vSpace(20.h),
            CustomTxtfield(
              validator: (v) =>
                  AppValidators.passwordValidator(_passwordController.text),

              hint: 'password',
              isPassword: true,
              controller: _passwordController,
            ),
            Spacing.vSpace(25.h),
            ActionsButton(
              onPressedLogin: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
              onPressedSignUp: () {
                context.pushNamed(AppRoutes.register);
              },
              onPressedGuest: () {},
            ),
          ],
        ),
      ),
    );
  }
}

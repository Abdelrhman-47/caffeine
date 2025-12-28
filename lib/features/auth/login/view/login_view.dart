import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/auth/login/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.opaque,
        child: Scaffold(

          resizeToAvoidBottomInset: true,
          body: Container(
              width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryColor.withOpacity(.5),
                AppColors.secondaryColor.withOpacity(.4),
                AppColors.secondaryColor.withOpacity(.3),
                Colors.white.withOpacity(.4),
                Colors.white.withOpacity(.4),
                Colors.white.withOpacity(.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
            child: LoginBody())
        ),
      ),
    );
  }
}

import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/onboarding/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          child: OnboardingBody()),
      ),
    );
  }
}
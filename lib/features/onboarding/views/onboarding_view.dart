import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/onboarding/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: AppColors.primaryColor,
        body: OnboardingBody(),
      ),
    );
  }
}
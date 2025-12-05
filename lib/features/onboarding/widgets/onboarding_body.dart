import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/onboarding/data/onboarding_data.dart';
import 'package:caffeine/features/onboarding/widgets/onboarding_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingBody extends StatefulWidget {
  OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _prefsHelper = getIt<PrefHelpers>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        OnboardingComponents(
          next: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          data: OnboardingData.onboarding[0],
        ),
        OnboardingComponents(
          next: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          data: OnboardingData.onboarding[1],
        ),
        OnboardingComponents(
          next: () async {
            await _prefsHelper.setOnboardingSeen();

            context.pushNamed(AppRoutes.login);
          },
          data: OnboardingData.onboarding[2],
        ),
      ],
    );
  }
}

import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigation();
    super.initState();
  }
  final _prefsHelper = getIt<PrefHelpers>();

  void navigation() {
    Future.delayed(Duration(milliseconds: 3400)).then((_) async {

      if (_prefsHelper.isOnboardingSeen()&&_prefsHelper.isLogin()) {
        context.pushNamed(AppRoutes.homeLayout);
      } else if (_prefsHelper.isOnboardingSeen()) {
        context.pushNamed(AppRoutes.login);
      }
      else {
        context.goNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Lottie.asset('assets/lotties/CoffeeBeansLoader.json',backgroundLoading: true)));
  }
}

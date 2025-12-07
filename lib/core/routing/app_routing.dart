import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/login/view/login_view.dart';
import 'package:caffeine/features/auth/register/view/register_view.dart';
import 'package:caffeine/features/details/view/details_view.dart';
import 'package:caffeine/features/cart/views/cart_view.dart';
import 'package:caffeine/features/favorite/views/favorite_view.dart';
import 'package:caffeine/features/home_layout/cubit/nav_bar_cubit.dart';
import 'package:caffeine/features/home_layout/views/home_layout_view.dart';
import 'package:caffeine/features/onboarding/views/onboarding_view.dart';
import 'package:caffeine/features/onboarding/splash_view.dart';
import 'package:caffeine/features/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        name: AppRoutes.splash,
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: AppRoutes.onboarding,
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.register,
        path: AppRoutes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.homeLayout,
        path: AppRoutes.homeLayout,
        builder: (context, state) => BlocProvider(
          create: (context) => NavBarCubit(),
          child: HomeLayoutView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.details,
        path: AppRoutes.details,
        builder: (context, state) => const DetailsView(),
      ),
      GoRoute(
        name: AppRoutes.cart,
        path: AppRoutes.cart,
        builder: (context, state) => const CartView(),
      ),
      GoRoute(
        name: AppRoutes.favorites,
        path: AppRoutes.favorites,
        builder: (context, state) => const FavoritesView(),
      ),
      GoRoute(
        name: AppRoutes.order,
        path: AppRoutes.order,
        builder: (context, state) => const OrderView(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404 Not Found'))),
  );
}

import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/cart/views/cart_view.dart';
import 'package:caffeine/features/favorite/cubit/fav_cubit.dart';
import 'package:caffeine/features/favorite/views/favorite_view.dart';
import 'package:caffeine/features/home/cubits/offers_cubit/offers_cubit.dart';
import 'package:caffeine/features/home/cubits/product_cubit.dart';
import 'package:caffeine/features/home/view/home_view.dart';
import 'package:caffeine/features/home_layout/cubit/nav_bar_cubit.dart';
import 'package:caffeine/features/home_layout/cubit/nav_bar_state.dart';
import 'package:caffeine/features/home_layout/widgets/cart_nav.dart';
import 'package:caffeine/features/home_layout/widgets/glass_nav.dart';
import 'package:caffeine/features/home_layout/helpers/nav_item_list.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLayoutView extends StatelessWidget {
  HomeLayoutView({super.key});
  final List<Widget> Screen = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NavBarCubit>()),
        BlocProvider(
          create: (context) => getIt<ProductCubit>()..getAllProducts(),
        ),
        BlocProvider(create: (context) => getIt<OffersCubit>()..getOffers()),
        BlocProvider(create: (context) => getIt<FavCubit>()..getAllFavs()),
      ],
      child: HomeView(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CartCubit>()..getCartItems()),
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => getIt<OrderCubit>()),
      ],
      child: CartView(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<FavCubit>()..getAllFavs()),
        BlocProvider(create: (context) => getIt<OffersCubit>()..getOffers()),
      ],
      child: FavoritesView(),
    ),
    BlocProvider(
      create: (context) => getIt<UserDataCubit>(),
      child: ProfileView(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavBarCubit>();
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Screen[cubit.state.index],
              Positioned(
                right: 0.w,
                left: 0.w,
                bottom: 0.h,
                child: UltraGlassNavBar(
                  currentIndex: cubit.state.index,
                  onTap: (int value) {
                    cubit.changeIndex(value);
                  },
                  items: NavItemList.items,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}

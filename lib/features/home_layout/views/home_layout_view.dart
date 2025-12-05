import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/cart/views/cart_view.dart';
import 'package:caffeine/features/favorite/views/favorite_view.dart';
import 'package:caffeine/features/home/view/home_view.dart';
import 'package:caffeine/features/home_layout/cubit/nav_bar_cubit.dart';
import 'package:caffeine/features/home_layout/cubit/nav_bar_state.dart';
import 'package:caffeine/features/home_layout/widgets/cart_nav.dart';
import 'package:caffeine/features/home_layout/widgets/glass_nav.dart';
import 'package:caffeine/features/home_layout/helpers/nav_item_list.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLayoutView extends StatelessWidget {
  HomeLayoutView({super.key});
  final List<Widget> Screen = [HomeView(), CartView(), FavoritesView(), BlocProvider(create: (context)=>getIt<UserDataCubit>(),
  child: ProfileView())];
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
                child: cubit.state.index == 1
                    ? CartNav()
                    : UltraGlassNavBar(
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

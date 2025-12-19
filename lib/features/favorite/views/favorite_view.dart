import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/favorite/cubit/fav_cubit.dart';
import 'package:caffeine/features/favorite/cubit/fav_state.dart';
import 'package:caffeine/features/favorite/widgets/ex_offer.dart';
import 'package:caffeine/features/favorite/widgets/fav_item.dart';
import 'package:caffeine/features/favorite/widgets/information_row.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/home/widgets/grid_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.vSpace(30.h),

                const InformationRow(),
                Spacing.vSpace(9.h),

                Divider(color: Colors.white, height: 3.h),
                Spacing.vSpace(20.h),

                const ExOffer(),
                Spacing.vSpace(20.h),

                Divider(color: Colors.white, height: 1.5.h),
                Spacing.vSpace(10.h),

                // ----- العنوان -----
                Text(
                  'Your Favourits ❤️',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Spacing.vSpace(10.h),

                SizedBox(
                  height: 210.h,
                  child: BlocBuilder<FavCubit, FavState>(
                    builder: (context, state) {
                      if (state is FavLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is FavLoaded) {
                        final favs = state.favsData;

                      return ListView.builder(
                       
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: favs.length,
                        itemBuilder: (ctx, index) {
                           final fav = favs[index];
                          final product =fav.product;
                        final isFave =fav.isFav;
                          return SizedBox(
                            width: 160.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: FavItem(
                                fav: product, isFave: isFave,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

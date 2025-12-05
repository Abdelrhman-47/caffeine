import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/features/home/widgets/category_row.dart';
import 'package:caffeine/features/home/widgets/grid_view_item.dart';
import 'package:caffeine/features/home/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HeaderSection(),
          ),

          SliverToBoxAdapter(
            child: Spacing.vSpace(20.h),
          ),

          SliverToBoxAdapter(
            child: CategoryRow(),
          ),

          SliverToBoxAdapter(
            child: Spacing.vSpace(20.h),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220.h,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () => context.pushNamed(AppRoutes.details),
                  child: CardItem(),
                ),
                childCount: 10,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: 100.h),
          ),
        ],
      );
  }
}

import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/features/home/cubit/product_cubit.dart';
import 'package:caffeine/features/home/cubit/product_state.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/home/widgets/category_row.dart';
import 'package:caffeine/features/home/widgets/grid_view_item.dart';
import 'package:caffeine/features/home/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderSection(),
          Spacing.vSpace(20.h),
          CategoryRow(),
          Spacing.vSpace(20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                bool isLoading = state is ProductLoading;
                List<ProductModel> products = [];
                if (state is ProductSuccess) {
                  products = state.products;
                }

                return Skeletonizer(
                  enabled: isLoading,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : () => context.pushNamed(AppRoutes.details),
                        child: CardItem(product: isLoading ? ProductModel.empty() : products[index]),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
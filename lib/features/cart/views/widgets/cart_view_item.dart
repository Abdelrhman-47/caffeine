  import 'package:caffeine/core/constants/app_colors.dart';
  import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_state.dart';
  import 'package:caffeine/features/home/data/product_model.dart';
  import 'package:caffeine/features/home/widgets/glass_container.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartViewItem extends StatelessWidget {
  CartViewItem({super.key, required this.realPrice, required this.productData, required this.productId});
    final double realPrice;
    final ProductModel productData;
    final int productId;

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: SizedBox(
          height: 150.h,
          child: Stack(
            children: [
              Positioned.fill(child: DarkGlassContainer(height: 150.h)),
              Positioned(
                left: 10.w,
                top: -10.h,
                bottom: -10.h,
                child: Image.network(
                productData.url,
                  width: 120.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 20.w,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                    productData.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                          context.read<CounterCubit>().decrement(productId);
                          },
                          child: GlassContainer(
                            height: 30.h,
                            width: 30.w,
                            padding: EdgeInsets.all(1.r),
                            blur: 1,
                            color: AppColors.primaryColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                            child: Icon(Icons.minimize, color: Colors.white),
                          ),
                        ),
                        Spacing.hSpace(6.w),
                        Text(
                        context.watch<CounterCubit>().getCount(productId).toString(),
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        Spacing.hSpace(6.w),
                        GestureDetector(
                          onTap: () {
                          context.read<CounterCubit>().increment(productId);
                          },
                          child: GlassContainer(
                            height: 30.h,
                            width: 30.w,
                            blur: 1,
                            color: AppColors.primaryColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),

                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                 
                    Text(
                    'Total Price \n      \$ ${realPrice * context.watch<CounterCubit>().getCount(productId)} ',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

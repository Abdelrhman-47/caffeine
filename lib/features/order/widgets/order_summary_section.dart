import 'dart:developer';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 60.sp,
                      ),
                      Spacing.vSpace(15.h),
                      Text(
                        'Order Placed Successfully!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.go(AppRoutes.homeLayout);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (message) {
              log('Error placing order: $message');
            },
            orElse: () {},
          );
        },
        child: DarkGlassContainer(
          height: 200.h,
          width: double.infinity,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pricing breakdown rows
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Original Price',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white70,
                          ),
                        ),
                        BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) => state.maybeWhen(
                            loaded: (orders) => Text(
                              '\$ ${context.read<OrderCubit>().calculateTotalPrice(orders).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            orElse: () => Text(
                              '\$ 0.00',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Use Coupon',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '\$ 0.20',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fee',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '\$ 0.04',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) => state.maybeWhen(
                            loaded: (orders) => Text(
                              '\$ ${context.read<OrderCubit>().calculateTotalPrice(orders) - 0.20}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            orElse: () => Text(
                              '\$ 0.00',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

               BlocBuilder<OrderCubit, OrderState>(
  builder: (context, state) {
    return state.maybeWhen(
      loaded: (orders) {
        return CustomButton(
          text: 'Confirm',
          onPressed: () {
        context.read<OrderCubit>().finalizeOrder(orders);
            context.read<CartCubit>().deleteall();
            context.read<OrderCubit>().deleteall();
            context.go(AppRoutes.homeLayout);
          },
          textColor: Colors.white,
          height: 45.h,
          width: 120.w,
          borderRadius: BorderRadius.circular(25.r),
          outLineButton: false,
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  },
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

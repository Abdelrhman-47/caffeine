import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomSection extends StatelessWidget {
  BottomSection({super.key, required this.state});
  final CartState state;

  @override
  Widget build(BuildContext context) {
    return DarkGlassContainer(
      height: 170.h,
      width: double.infinity,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h, left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                ),
                SizedBox(height: 5.h),
                Text(
                  '\$ ${context.read<CartCubit>().calculateTotal(state.cartItems, context.watch<CounterCubit>().state.counts).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CustomButton(
              text: 'Confirm Order',
              onPressed: () async {
                await context.read<OrderCubit>().confirmCartOrders(
                  cartItems: state.cartItems,
                  productCounts: context.read<CounterCubit>().state.counts,
                );
                context.goNamed(
                  AppRoutes.order,
                  extra: context
                      .read<CartCubit>()
                      .calculateTotal(
                        state.cartItems,
                        context.read<CounterCubit>().state.counts,
                      )
                      
                );
              },

              height: 50.h,
              width: 160.w,
              borderRadius: BorderRadius.circular(25.r),
              outLineButton: false,
              backgroundColor: AppColors.primaryColor,
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

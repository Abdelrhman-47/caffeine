import 'dart:developer';

import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/constants/text_style.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/details/cubit/real_price_cubit.dart';
import 'package:caffeine/features/details/cubit/real_price_state.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.avragePrice,
    required this.productId,
  });
  final double avragePrice;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return DarkGlassContainer(
      height: 130.h,
      width: double.infinity,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50.r),
        topRight: Radius.circular(50.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacing.hSpace(10.w),

          BlocBuilder<RealPriceCubit, RealPriceState>(
            builder: (context, state) {
              if (state is RealPriceLoading) {
                return CircularProgressIndicator(color: AppColors.primaryColor);
              }
              if (state is RealPriceError) {}
              if (state is RealPriceChanged) {
                final price = state.realPrice;
                final finalPrice = state.realPrice;

                return Text(
                  "Price\n \$${price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                );
              }
              if (state is RealPriceError) {
                return Text(state.message);
              }
              return Text(
                'Price\n \$${avragePrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.sp, color: Colors.white),
              );
            },
          ),
          Spacer(),
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state is CartItemAdded) {
                Navigator.pop(context);
              }
            },
            child: CustomButton(
              text: 'Add to cart',
              onPressed: () {
                final price = context.read<RealPriceCubit>().realPrice;
                BlocProvider.of<CartCubit>(context).addToCart(productId, price);
              },
              textColor: Colors.white,
              height: 50.h,
              width: 100.w,
              borderRadius: BorderRadius.circular(12.r),
              outLineButton: false,
              backgroundColor: AppColors.primaryColor,
              textStyle: AppStyle.nextbutton,
            ),
          ),
          Spacing.hSpace(10.w),
        ],
      ),
    );
  }
}

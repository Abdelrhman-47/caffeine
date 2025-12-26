import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/cart/views/widgets/counter_section.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartViewItem extends StatelessWidget {
  CartViewItem({
    super.key,
    required this.realPrice,
    required this.productData,
    required this.productId,
  });
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
              child: CachedNetworkImage(
                imageUrl: productData.url,
                width: 120.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.image),
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
                  CounterSection(productId: productId),
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

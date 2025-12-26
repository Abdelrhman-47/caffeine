import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/order/data/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SizedBox(
        height: 120.h,
        child: Stack(
          children: [
            Positioned.fill(child: DarkGlassContainer(height: 100.h)),
            // Product Image
            Positioned(
              left: 10.w,
              top: -10.h,
              bottom: -10.h,
              child: order.product.url.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: order.product.url,
                      width: 120.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 120.w,
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 50.sp,
                      ),
                    )
                  : Icon(Icons.image, color: Colors.white, size: 50.sp),
            ),
            // Details
            Positioned(
              left: 130.w,
              top: 10.h,
              right: 10.w,
              bottom: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    order.product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacing.vSpace(5.h),
                  Text(
                    'Date: ${DateFormat('MMM d, yyyy').format(order.createdAt)}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.white70),
                  ),
                  Spacing.vSpace(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Count: ${order.count}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                      Text(
                        '\$${order.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
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

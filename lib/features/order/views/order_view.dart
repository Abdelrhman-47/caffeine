import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart' show Spacing;
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/home_layout/views/home_layout_view.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late final List<Color> _gradientColors;
  @override
  void initState() {
    context.read<OrderCubit>().getUserOrders();
    super.initState();
    _gradientColors = [
      AppColors.secondaryColor.withOpacity(.5),
      AppColors.secondaryColor.withOpacity(.4),
      AppColors.secondaryColor.withOpacity(.3),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Spacing.vSpace(30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.go(AppRoutes.homeLayout);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        ),
                        Spacing.hSpace(88.w),
                        Text(
                          'order Place',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.vSpace(30.h),
                  Expanded(
                    child: BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (state is OrderLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is OrderError) {
                          return Center(child: Text('Error: ${state.message}'));
                        } else if (state is OrderLoaded) {
                          if (state.orders.isEmpty) {
                            return const Center(
                              child: Text(
                                'No orders found',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 12.h,
                            ),
                            itemCount: state.orders.length,
                            itemBuilder: (context, index) {
                              final order = state.orders[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SizedBox(
                                  height: 120.h,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: DarkGlassContainer(
                                          height: 100.h,
                                        ),
                                      ),
                                      // Product Image
                                      Positioned(
                                        left: 10.w,
                                        top: -10.h,
                                        bottom: -10.h,
                                        child: order.product.url.isNotEmpty
                                            ? Image.network(
                                                order.product.url,
                                                width: 120.w,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.white,
                                                      size: 50.sp,
                                                    ),
                                              )
                                            : Icon(
                                                Icons.image,
                                                color: Colors.white,
                                                size: 50.sp,
                                              ),
                                      ),
                                      // Details
                                      Positioned(
                                        left: 130.w,
                                        top: 10.h,
                                        right: 10.w,
                                        bottom: 10.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            Spacing.vSpace(5.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Count: ${order.count}',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '\$${order.totalPrice.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.primaryColor,
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
                            },
                          );
                        }
                        return Center(
                          child: Text(
                            'good luck',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: DarkGlassContainer(
                height: 200.h,
                width: double.infinity,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
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
                                builder: (context, state) {
                                  if (state is OrderLoaded) {
                                    List<dynamic> orders = state.orders;
                                    return Text(
                                      '\$ ${context.read<OrderCubit>().calculateTotalPrice(orders).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return Text(
                                    '\$ 0.00',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                    ),
                                  );
                                },
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
                          Divider(
                            color: Colors.white.withOpacity(0.3),
                            thickness: 1,
                          ),
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
                                builder: (context, state) {
                                  if (state is OrderLoaded) {
                                    List<dynamic> orders = state.orders;
                                    return Text(
                                      '\$ ${context.read<OrderCubit>().calculateTotalPrice(orders) - 0.20}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return Text(
                                    '\$ 0.00',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      CustomButton(
                        text: 'Confirm',
                        onPressed: () {
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
                                      Navigator.of(ctx).pop(); // Close dialog
                                      context.read<CartCubit>().deleteall();
                                      context.read<OrderCubit>().deleteall();
                                      context.go(
                                        AppRoutes.homeLayout,
                                      ); // Go to home
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

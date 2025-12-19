import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UserOrdersView extends StatefulWidget {
  const UserOrdersView({super.key});

  @override
  State<UserOrdersView> createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView> {
  late final List<Color> _gradientColors;

  @override
  void initState() {
    super.initState();
    _gradientColors = [
      AppColors.secondaryColor.withOpacity(.5),
      AppColors.secondaryColor.withOpacity(.4),
      AppColors.secondaryColor.withOpacity(.3),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.3),
    ];
    // Trigger fetching orders
    context.read<OrderCubit>().getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 25.sp,
                        color: Colors.white,
                      ),
                    ),
                    Spacing.hSpace(88.w),
                    Text(
                      'My Orders',
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
                      return const Center(child: CircularProgressIndicator());
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
                                    child: DarkGlassContainer(height: 100.h),
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
                                                (context, error, stackTrace) =>
                                                    Icon(
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
                                              MainAxisAlignment.spaceBetween,
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
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

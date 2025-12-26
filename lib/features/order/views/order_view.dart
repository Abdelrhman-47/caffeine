import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart' show Spacing;
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:caffeine/features/order/widgets/order_item.dart';
import 'package:caffeine/features/order/widgets/order_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                      builder: (context, state) => state.when(
                        initial: () => const Center(
                          child: Text(
                            'No orders found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        success: () => const Center(
                          child: Text(
                            'Order placed successfully',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        error: (message) => Center(
                          child: Text(
                            'Error: $message',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        loaded: (orders) {
                          if (orders.isEmpty) {
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
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return OrderItem(order: orders[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const OrderSummarySection(),
          ],
        ),
      ),
    );
  }
}

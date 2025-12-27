import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/constants/text_style.dart';
import 'package:caffeine/core/helpers/spacing.dart' show Spacing;
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:caffeine/features/order/widgets/custom_list_tile.dart';
import 'package:caffeine/features/order/widgets/order_item.dart';
import 'package:caffeine/features/order/widgets/order_summary_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderView extends StatefulWidget {
   OrderView({super.key,required this.totalPrice});
   final double totalPrice;

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

  String selectedMethod = 'Cash';

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
                  BlocBuilder<OrderCubit, OrderState>(
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
                        return SizedBox(
                          height: 200.h,
                          width: 375.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 12.h,
                            ),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: OrderItem(order: orders[index]),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Spacing.vSpace(20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacing.vSpace(5.h),
                  
                         CustomListTile(
          paymentName: "Pay cash",
          tileColor: AppColors.primaryColor,
          value: 'Cash',
          groupValue: selectedMethod,
          showSubtitle: false,
          onChanged: (v) {
            setState(() => selectedMethod = v);
          },
        ),
        Spacing.vSpace(5.h),
        CustomListTile(
          paymentName: 'Pay by card',
          tileColor: Colors.blue.shade900,
          value: 'Visa',
          groupValue: selectedMethod,
          showSubtitle: true,
          onChanged: (v) {
            setState(() => selectedMethod = v);
          },
        ),
                        Spacing.vSpace(8.h),
                        Align(
                          alignment: Alignment.center,
                          child: selectedMethod == 'Visa'
                              ? CustomButton(
                                  backgroundColor: AppColors.primaryColor,
                                  text: "Pay Now",
                                  onPressed: () async {
                                    await FlutterPaymob.instance.payWithCard(
                                      title: Text(
                                        "Card Payment",
                                      ), // Optional - Custom title AppBar
                                      appBarColor: Colors
                                          .blueAccent, // Optional - Custom AppBar color
                                      context: context,
                                      currency: "EGP",
                                      amount:widget.totalPrice,
                                      onPayment: (response) {
                                        if (response.success) {
                                          print(
                                            "🎉 Payment Success! TxID: ${response.transactionID}",
                                          );
                                        } else {
                                          print(
                                            "❌ Payment Failed: ${response.message}",
                                          );
                                        }
                                      },
                                    );
                                  },
                                  textColor: Colors.white,
                                  height: 40.h,
                                  width: 110.w,
                                  borderRadius: BorderRadius.circular(12.r),
                                  outLineButton: false,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
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

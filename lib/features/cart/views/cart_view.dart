import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';

import 'package:caffeine/features/cart/views/widgets/cart_view_item.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

// cart_view.dart
class _CartViewState extends State<CartView> {
  late final List<Color> _gradientColors;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    _gradientColors = [
      AppColors.secondaryColor.withOpacity(.5),
      AppColors.secondaryColor.withOpacity(.4),
      AppColors.secondaryColor.withOpacity(.3),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.3),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<CartCubit, CartState>(
          // استخدم listener للـ messages
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
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
                      Expanded(
                        child: state.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : state.cartItems.isEmpty
                            ? const Center(child: Text('السلة فارغة'))
                            : ListView.builder(
                                controller: controller,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                                itemCount: state.cartItems.length,
                                itemBuilder: (context, index) {
                                  final cartItem = state.cartItems[index];

                                  double offset = 0;
                                  if (controller.hasClients) {
                                    offset = controller.offset / 130 - index;
                                  }
                                  offset = offset.clamp(0, 1);

                                  return Dismissible(
                                    key: ValueKey(cartItem.id),
                                    direction: DismissDirection.horizontal,
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      context.read<CartCubit>().delete(
                                        cartItem.id,
                                      );
                                    },
                                    child: Transform.scale(
                                      scale: 1 - (offset * 0.1),
                                      child: CartViewItem(
                                        realPrice: cartItem.realPrice,
                                        productData: cartItem.product,
                                        productId: cartItem.product.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                if (state.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: DarkGlassContainer(
                      height: 170.h,
                      width: double.infinity,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 30.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Price',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white70,
                                  ),
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
                              onPressed: () => context
                                  .read<OrderCubit>()
                                  .confirmCartOrders(
                                    cartItems: state.cartItems,
                                    productCounts: context
                                        .read<CounterCubit>()
                                        .state
                                        .counts,
                                  )
                                  .then((_) {
                                    context.push(AppRoutes.order);
                                  }),
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
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // double _calculateTotal(CartState state) {
  //   return state.cartItems.fold<double>(
  //                                 0,
  //                                 (sum, item) =>
  //                                     sum +
  //                                     item.realPrice *
  //                                         context
  //                                             .watch<CounterCubit>()
  //                                             .getCount(item.product.id),
  //                               );
  // }

  // void _confirmOrder(CartState state) {
  //   for (var item in state.cartItems) {
  //     final count = context.read<CounterCubit>().getCount(item.product.id);
  //     if (count > 0) {
  //       context.read<OrderCubit>().placeOrder(
  //             count: count,
  //             itemPrice: item.realPrice,
  //             productId: item.product.id,
  //             totalPrice: item.realPrice * count,
  //           );
  //     }
  //   }
  //   context.push(AppRoutes.order);
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

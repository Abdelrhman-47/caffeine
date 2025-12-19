import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/cart/data/cart_model.dart';
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
    // Fetch cart items from API when view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCartItems();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  Expanded(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            if (state is CartLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CartError) {
                              return Center(child: Text(state.message));
                            }
                            if (state is CartLoaded) {
                              final List<CartModel> cartModel = state.cartItems;

                              return ListView.builder(
                                controller: controller,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 12.h,
                                ),
                                itemCount: cartModel.length,
                                itemBuilder: (context, index) {
                                  final realPrice = cartModel[index].realPrice;
                                  final product = cartModel[index].product;

                                  double offset = 0;
                                  if (controller.hasClients) {
                                    offset = controller.offset / 130 - index;
                                  }
                                  offset = offset.clamp(0, 1);

                                  return Dismissible(
                                    key: ValueKey(index),
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
                                        cartModel[index].id,
                                      );
                                    },
                                    child: Transform.scale(
                                      scale: 1 - (offset * 0.1),
                                      child: CartViewItem(
                                        realPrice: realPrice,
                                        productData: product,
                                        productId: product.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return Center(child: Text('null'));
                          },
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
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              // if (state is CartLoaded) {
                              if (state is CartLoaded &&
                                  state.cartItems.isNotEmpty) {
                                final total = state.cartItems.fold<double>(
                                  0,
                                  (sum, item) =>
                                      sum +
                                      item.realPrice *
                                          context
                                              .watch<CounterCubit>()
                                              .getCount(item.product.id),
                                );
                                return Text(
                                  '\$ ${total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      CustomButton(
                        text: 'Confirm Order',
                        onPressed: () {
                          if (context.read<CartCubit>().state is CartLoaded) {
                            final cartItems =
                                (context.read<CartCubit>().state as CartLoaded)
                                    .cartItems;
                            for (var item in cartItems) {
                              final count = context
                                  .read<CounterCubit>()
                                  .getCount(item.product.id);
                              if (count > 0) {
                                context.read<OrderCubit>().placeOrder(
                                  count: count,
                                  itemPrice: item.realPrice,
                                  productId: item.product.id,
                                  totalPrice: item.realPrice * count,
                                );
                              }
                            }
                          }
                          // context.read<CartCubit>().deleteall();
                          context.push(AppRoutes.order);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => BlocProvider(
                          //       create: (context) => getIt<OrderCubit>(),
                          //       child: UserOrdersView(),
                          //     ),
                          //   ),
                          // );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

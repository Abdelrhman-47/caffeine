import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/views/widgets/bottom_section.dart';
import 'package:caffeine/features/cart/views/widgets/cart_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<CartCubit>().getCartItems();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<CartCubit, CartState>(
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
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Your Cart is Empty',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                    child: BottomSection(state: state),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

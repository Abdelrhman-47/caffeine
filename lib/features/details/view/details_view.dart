import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/network/connectivity_cubit.dart';
import 'package:caffeine/core/network/connectivity_state.dart';
import 'package:caffeine/core/widgets/connectivity_builder.dart';
import 'package:caffeine/core/widgets/no_internet.dart';
import 'package:caffeine/features/details/cubit/real_price_cubit.dart';
import 'package:caffeine/features/details/cubit/real_price_state.dart';
import 'package:caffeine/features/details/widgets/bottom_section.dart';
import 'package:caffeine/features/details/widgets/header_section.dart';
import 'package:caffeine/features/details/widgets/image_selection.dart';
import 'package:caffeine/features/details/widgets/size_selector.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  int selectedSizeIndex = 1; // Default: Medium

  static const List<String> sizes = ["large", "medium", "small"];
  static const List<double> sizeScale = [1.4, 1.2, 1];

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
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityBuilder(
      builder: (context, isConnected) => BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivityConnected) {
            context.read<RealPriceCubit>().retry();
          }
        },
        child: BlocBuilder<RealPriceCubit, RealPriceState>(
          builder: (context, state) {
            if (state is RealPriceError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is RealPriceNoInternet) {
              return const NoInternetScreen();
            }
            return SafeArea(
              child: Scaffold(
                bottomNavigationBar: BottomSection(
                  avragePrice: widget.product.price,
                  productId: widget.product.id,
                ),
                backgroundColor: Colors.white,
                body: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _gradientColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderSectionDetailes(),

                        SizedBox(height: 80.h),

                        ProductImageSection(
                          scale: sizeScale[selectedSizeIndex],
                          imagePath: widget.product.url,
                        ),

                        Spacing.vSpace(90.h),

                        SizeSelector(
                          sizes: sizes,
                          selectedIndex: selectedSizeIndex,
                          onSizeSelected: (index) {
                            setState(() {
                              selectedSizeIndex = index;
                            });
                          },
                          productInt: widget.product.id,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

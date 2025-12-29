import 'dart:ui';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/favorite/cubit/fav_cubit.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:caffeine/core/widgets/product_image.dart';

class CardItem extends StatefulWidget {
  CardItem({super.key, required this.product, required this.isFave});

  final ProductModel product;
  final bool isFave;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late bool _localIsFave;

  @override
  void initState() {
    super.initState();
    _localIsFave = widget.isFave;
  }

  @override
  void didUpdateWidget(covariant CardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFave != widget.isFave) {
      _localIsFave = widget.isFave;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 120, sigmaY: 450),
        child: Container(
          
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.grey.shade300,
                Colors.grey.shade400,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(7.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _localIsFave = !_localIsFave;
                    });
                    if (_localIsFave) {
                      context.read<FavCubit>().addFavProduct(widget.product.id);
                    } else {
                      context.read<FavCubit>().deletFavProduct(
                        widget.product.id,
                      );
                    }
                  },
                  child: SvgPicture.asset(
                    _localIsFave
                        ? 'assets/svgs/fav.svg'
                        : 'assets/svgs/no_fav.svg',
                    width: 10.w,
                    height: 16.h,
                    color: _localIsFave ? Colors.red : Colors.white,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -10.h,
                      right: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/pnga/shadow.png',
                        width: 10.w,
                        height: 35.h,
                        color: Colors.black26,
                      ),
                    ),
                    Center(
                      child: ProductCardImage(
                        imageUrl: widget.product.url,
                        size: 115.sp,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacing.vSpace(2.h),
                      Row(
                        children: [
                          Spacing.hSpace(1.w),
                          Text(
                            '\$ ${widget.product.price.toStringAsFixed(1)}',

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/rait.svg',
                                width: 16.w,
                                height: 16.h,
                              ),
                              Spacing.hSpace(2.w),
                              Text(widget.product.rate),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

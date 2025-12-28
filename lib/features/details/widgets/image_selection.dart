import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:caffeine/core/widgets/product_image.dart';

class ProductImageSection extends StatelessWidget {
  final double scale;
  final String imagePath;

  const ProductImageSection({required this.scale, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (Widget child, Animation<double> animation) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(1.5, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(opacity: fadeAnimation, child: child),
            );
          },
          child: Container(
            key: ValueKey<double>(scale),
            width: double.infinity,
            height: 300.h,
            child: Transform.scale(
              scale: scale,
              child: ProductDetailImage(
                imageUrl: imagePath,
                height: 300.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

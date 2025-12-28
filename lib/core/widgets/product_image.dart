import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Reusable product image widget that ensures consistent sizing and display
/// across all product images in the app
class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool showPlaceholder;

  const ProductImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.showPlaceholder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: showPlaceholder
          ? (context, url) => Container(
              width: width,
              height: height,
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.shade400,
                  ),
                ),
              ),
            )
          : null,
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: Icon(
          Icons.local_cafe,
          size: (width ?? 50) * 0.4,
          color: Colors.grey.shade400,
        ),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }
}

/// Product image specifically for grid/card views
/// Ensures 1:1 aspect ratio with consistent sizing
class ProductCardImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const ProductCardImage({Key? key, required this.imageUrl, this.size = 115})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductImage(
      imageUrl: imageUrl,
      width: size.w,
      height: size.h,
      fit: BoxFit.contain,
    );
  }
}

/// Product image for detail/large views
/// Maintains aspect ratio while filling available space
class ProductDetailImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final BoxFit fit;

  const ProductDetailImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: height,
      fit: fit,
    );
  }
}

/// Product image for cart items
/// Optimized for horizontal list display
class ProductCartImage extends StatelessWidget {
  final String imageUrl;
  final double width;

  const ProductCartImage({Key? key, required this.imageUrl, this.width = 120})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductImage(
      imageUrl: imageUrl,
      width: width.w,
      fit: BoxFit.contain,
    );
  }
}

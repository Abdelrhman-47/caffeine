import 'dart:ui';
import 'package:flutter/material.dart';

// ============================================
// 🪟 GLASS CONTAINER
// ============================================

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double blur;
  final Color? color;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 10,
    this.color,
    this.border,
    this.boxShadow, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? Colors.white.withOpacity(0.1),
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              border: border ??
                  Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

// ============================================
// 🎨 PRE-STYLED VARIANTS
// ============================================

// Dark Glass
class DarkGlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const DarkGlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      color: Colors.black.withOpacity(0.3),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
      child: child,
    );
  }
}

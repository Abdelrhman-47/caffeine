
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final bool outLineButton;
  final Color? borderColor;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
     this.backgroundColor,
    required this.textColor,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.outLineButton,
    this.borderColor, required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: outLineButton
              ? BorderSide(color: borderColor ?? Colors.brown, width: 2.w)
              : null,
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding:  EdgeInsets.symmetric(vertical: 9.h, horizontal: 0.w),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(text, style: textStyle)),
      
    );
  }
}

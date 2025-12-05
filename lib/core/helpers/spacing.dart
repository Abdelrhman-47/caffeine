import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spacing {
  static SizedBox vSpace(double height) => SizedBox(height: height.h);

  static SizedBox hSpace(double width) => SizedBox(width: width.w);
}

import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return  RichText(
                    text: TextSpan(
                      style: const TextStyle(),
                      children: [
                        WidgetSpan(
                          child: Text(
                            'Already have an account?  ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
      
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(     decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
      
                                color: AppColors.buttonColor,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}
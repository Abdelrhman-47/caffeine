import 'package:caffeine/features/home/widgets/cursoul_slider_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExOffer extends StatelessWidget {
  const ExOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
                'Exclusive Offer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),)
            
          
             , CursoulSliderOptions(),
    ],);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          SizedBox(
            height: 380.h,
            width: double.infinity,
            child: Image.asset('assets/pnga/header.png'),
          ),
            SizedBox(
            height: 370.h,
            width: double.infinity,
            child: Image.asset('assets/pnga/bottom.png'),
          ),
        ],
      ),
    );
  }
}

import 'package:caffeine/core/sheared_widgets/glass_container.dart';
import 'package:caffeine/features/auth/login/widgets/login_components.dart';
import 'package:caffeine/features/auth/widgets/back_ground_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              BackGroundImage(),

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: glassContainer(child: LoginComponents()),
                ),
              ),
            ],
          );
  }
}
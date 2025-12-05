import 'package:caffeine/core/sheared_widgets/glass_container.dart';
import 'package:caffeine/features/auth/register/widgets/register_components.dart';
import 'package:caffeine/features/auth/widgets/back_ground_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
            BackGroundImage(),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: glassContainer(
                    child: RegisterComponents()
                  ),
                ),
              ),
            ],
          );
  }
}
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/constants/text_style.dart';
import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/features/onboarding/data/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingComponents extends StatelessWidget {
   OnboardingComponents({
    super.key,
    this.skip,
 
   required this.next, required this.data,
  });
  final void Function()? skip;
  final void Function() next;


final _prefsHelper = getIt<PrefHelpers>();
  final onboardingData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Spacing.vSpace(20.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:  EdgeInsets.only(right: 15.w),
              child: GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.login);
                  _prefsHelper.setOnboardingSeen();

                },
                child: Text('Skip', style: AppStyle.skipStyle),
              ),
            ),
          ),
          Spacing.vSpace(70.h),
          SizedBox(width: 300.w, height: 200.h,
            child: Image.asset(data.centerImage)),
          Spacing.vSpace(60.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 50.w),
            child: SizedBox(height: 190.h,
              child: Column(
                children: [
                  Text(
                    data.headLine,
                    style:AppStyle.headLineStyle,
                                        textAlign: TextAlign.start,

                  ),
                  Spacing.vSpace(10.h),
                  Text(
                    data.suptitle,
                    style: AppStyle.supTitleStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Spacing.vSpace(100.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(data.bottomImage),
                Spacer(),
                CustomButton(
                  backgroundColor: AppColors.buttonColor,
                  text: 'Next',
                  onPressed: next,
                  textColor: Colors.black,
                  height: 44.h,
                  width: 130.w,
                  textStyle: AppStyle.nextbutton,
                  borderRadius: BorderRadius.circular(18.r),
                  outLineButton: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

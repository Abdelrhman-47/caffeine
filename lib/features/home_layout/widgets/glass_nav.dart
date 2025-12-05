// import 'dart:ui';
// import 'package:caffeine/core/constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class UltraGlassNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   final List<UltraNavItem> items;

//   const UltraGlassNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final count = items.length;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.7),
//               blurRadius: 10.r,
//               offset: const Offset(1, 1),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(40),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 100.dg, sigmaY: 20.dm),
//             child: Container(
//               height: 70,
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.14),
//                 borderRadius: BorderRadius.circular(40),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.18),
//                   width: 1.2,
//                 ),
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   /// ⭐ الدائرة المتحركة (Spring Animation)
//                   AnimatedAlign(
//                     alignment: Alignment(
//                       (currentIndex / (count - 1)) * 2 - 1,
//                       0,
//                     ),
//                     curve: Curves.elasticOut,
//                     duration: const Duration(milliseconds: 900),
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black.withOpacity(0.55),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.7),
//                             blurRadius: 20,
//                             spreadRadius: 1,
//                           ),
//                           BoxShadow(
//                             color: AppColors.secondaryColor.withOpacity(0.8),
//                             blurRadius: 15,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   /// ⭐ عناصر الـ Bottom Nav
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(count, (i) {
//                       final selected = i == currentIndex;
//                       final item = items[i];

//                       return GestureDetector(
//                         onTap: () => onTap(i),
//                         behavior: HitTestBehavior.translucent,
//                         child: SizedBox(
//                           width: 47.w,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               AnimatedSwitcher(
//                                 duration: const Duration(milliseconds: 280),
//                                 switchInCurve: Curves.easeOut,
//                                 switchOutCurve: Curves.easeIn,
//                                 child: IconTheme(
//                                   key: ValueKey(selected),
//                                   data: IconThemeData(
//                                     size: selected ? 26 : 22,
//                                     color: selected
//                                         ?  AppColors.buttonColor
//                                         : Colors.white,
//                                   ),
//                                   child:
//                                       selected ? item.activeIcon : item.icon,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               AnimatedOpacity(
//                                 opacity: selected ? 1 : 0.55,
//                                 duration: const Duration(milliseconds: 260),
//                                 child: Text(
//                                   item.label,
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     fontWeight: selected
//                                         ? FontWeight.w600
//                                         : FontWeight.w400,
//                                     color: selected
//                                         ? AppColors.buttonColor
//                                         : Colors.white,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UltraNavItem {
//   final Widget icon;
//   final Widget activeIcon;
//   final String label;

//   UltraNavItem({
//     required this.icon,
//     required this.activeIcon,
//     required this.label,
//   });
// }

import 'dart:ui';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UltraGlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<UltraNavItem> items;

  const UltraGlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final count = items.length;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            // ✅ Darker shadow for white background
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 9.r,
              offset: const Offset(0, 30),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 1.r,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 48.h,
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                // ✅ Darker glass effect for white background
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// ⭐ Moving Circle with better contrast
                  AnimatedAlign(
                    alignment: Alignment(
                      (currentIndex / (count - 1)) * 2 - 1,
                      0,
                    ),
                    curve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 900),
                    child: Container(
                      width: 50.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // ✅ Brighter active indicator
                       color: Colors.black.withOpacity(.2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.7),
                            blurRadius: 16,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// ⭐ Nav Items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(count, (i) {
                      final selected = i == currentIndex;
                      final item = items[i];

                      return GestureDetector(
                        onTap: () => onTap(i),
                        behavior: HitTestBehavior.translucent,
                        child: SizedBox(
                          width: 50.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 280),
                                switchInCurve: Curves.easeOut,
                                switchOutCurve: Curves.easeIn,
                                child: IconTheme(
                                  key: ValueKey(selected),
                                  data: IconThemeData(
                                    size: selected ? 24 : 15,
                                    // ✅ Better colors for dark navbar
                               
                                  ),
                                  child: selected ? item.activeIcon : item.icon,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              AnimatedOpacity(
                                opacity: selected ? 1 : 0.8,
                                duration: const Duration(milliseconds: 260),
                                child: Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: selected
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UltraNavItem {
  final Widget icon;
  final Widget activeIcon;
  final String label;

  UltraNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
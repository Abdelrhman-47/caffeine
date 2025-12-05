import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
class AppTheme {
  // --------------------------
  // LIGHT THEME
  // --------------------------
  static ThemeData primary = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary:  AppColors.secondaryColor,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    scaffoldBackgroundColor:
    AppColors.primaryColor,
    // Color(0XFF2B1F1A),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      // titleTextStyle: TextStyle(
      //   color: Colors.black,
      //   fontSize: 20,
      //   fontWeight: FontWeight.bold,
      // ),
      iconTheme: IconThemeData(color: Colors.black),
    ),);}

    // textTheme: TextTheme(
    //   titleLarge: TextStyle(fontFamily:'Urbanist',fontSize: 30.sp,fontWeight:FontWeight.bold ,color: AppColors.primaryColor),
    //   titleMedium: TextStyle(fontFamily:'Urbanist',fontSize: 16.sp,fontWeight:FontWeight.w500,color: AppColors.secoundColor ),
    // ),

  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: AppColors.primaryColor,
  //       foregroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(8.r)),
  //       ),
  //     ),
  //   ),
  // );

  // --------------------------
  // DARK THEME
  // --------------------------
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     useMaterial3: true,

//     colorScheme: ColorScheme.dark(
//       primary: Colors.blue,
//       secondary: Colors.blueAccent,
//       surface: Colors.black,
//       onSurface: Colors.white,
//     ),

//     scaffoldBackgroundColor: Colors.black,

//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.black,
//       elevation: 0,
//       titleTextStyle: TextStyle(
//         color: Colors.white,
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       iconTheme: IconThemeData(color: Colors.white),
//     ),

//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
//       bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
//     ),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blueAccent,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//       ),
//     ),
//   );
// }

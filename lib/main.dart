import 'package:caffeine/core/constants/app_theme.dart';
import 'package:caffeine/core/routing/app_routing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const Caffeine());
}

class Caffeine extends StatelessWidget {
  const Caffeine({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        theme: AppTheme.primary.copyWith(
          textTheme: GoogleFonts.merriweatherTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

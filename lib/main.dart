import 'package:caffeine/core/constants/app_theme.dart';
import 'package:caffeine/core/helpers/confige_message.dart';
import 'package:caffeine/core/routing/app_routing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
    await ConfigMessage.init();
    FirebaseMessaging.instance.subscribeToTopic("menu_updates");


  runApp(const Caffeine());
}

class Caffeine extends StatelessWidget {
  const Caffeine({super.key});

  @override Widget build(BuildContext context) {
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

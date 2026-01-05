import 'dart:async';

import 'package:caffeine/core/constants/app_theme.dart';
import 'package:caffeine/core/helpers/confige_message.dart';
import 'package:caffeine/core/routing/app_routing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/core/widgets/no_internet.dart';
import 'package:caffeine/features/home/data/local_service.dart';
import 'package:caffeine/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
      await InitHive.init();

  await setupDependencies();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
    await ConfigMessage.init();
    FirebaseMessaging.instance.subscribeToTopic("menu_updates");


  runApp(const Caffeine());
}

class Caffeine extends StatefulWidget {
  const Caffeine({super.key});

  @override
  State<Caffeine> createState() => _CaffeineState();
}

class _CaffeineState extends State<Caffeine> {
//  bool _isConected=false;
 //   late StreamSubscription<InternetStatus> _subscription;
    @override
  // void initState() {
  // _subscription = InternetConnection().onStatusChange.listen((status) {
  //   switch(status){
  //     case InternetStatus.connected:
  //       setState(() {
  //         _isConected=true;
  //       });
  //       break;
  //     case InternetStatus.disconnected:
  //       setState(() {
  //         _isConected=false;
  //       });
  //       break;
  //   }
  //   });    super.initState();
  // }
  // @override
  // void dispose() {
  //   _subscription.cancel();
  //   super.dispose();
  // }
    

  @override Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child://_isConected ?
       MaterialApp.router(
        theme: AppTheme.primary.copyWith(
          textTheme: GoogleFonts.merriweatherTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      )
      // :MaterialApp(
      //   theme: AppTheme.primary.copyWith(
      //     textTheme: GoogleFonts.merriweatherTextTheme(
      //       Theme.of(context).textTheme,
      //     ),
      //   ),
      //   debugShowCheckedModeBanner: false,
      //   home: const NoInternetScreen(),
      // ),
    );
  }
}

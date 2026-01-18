import 'package:caffeine/core/constants/app_theme.dart';
import 'package:caffeine/core/helpers/confige_message.dart';
import 'package:caffeine/core/network/connectivity_cubit.dart';
import 'package:caffeine/core/network/connectivity_state.dart';
import 'package:caffeine/core/routing/app_routing.dart';
import 'package:caffeine/core/utils/di_helpers.dart';
import 'package:caffeine/core/utils/hive_init.dart';
import 'package:caffeine/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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

    

  @override Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => getIt<ConnectivityCubit>(),
        child: BlocListener<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectivityDisconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No internet connection'),
                  duration: Duration(seconds: 3),
                ),
              );
            } else if (state is ConnectivityConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Internet connection restored'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: MaterialApp.router(
          theme: AppTheme.primary.copyWith(
            textTheme: GoogleFonts.merriweatherTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
        ),
      )
  
    );
  }
}

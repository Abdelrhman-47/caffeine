import 'package:caffeine/core/constants/app_constats.dart';
import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/core/network/dio_clint.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/data/repo.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/data/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await Supabase.initialize(
    url: 'https://gaogtmhoavbrmblbbfwi.supabase.co',
    anonKey: AppConstats.annoneKey,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<PrefHelpers>(PrefHelpers(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(dioClient: getIt<DioClient>()),
  );
  

  getIt.registerLazySingleton<UserRepo>(
    () => UserRepoImplement(
      supabase: getIt<SupabaseClient>(),
      sharedPref: getIt<PrefHelpers>(),
      apiServices: getIt<ApiServices>(),
    ),
  );
  getIt.registerFactory<AuthCubit>(() => AuthCubit(user: getIt<UserRepo>()));


  getIt.registerLazySingleton<UserDataRepositoryImpl >(()=> UserDataRepositoryImpl (apiServices: getIt<ApiServices>()));
    getIt.registerFactory<UserDataCubit>(() => UserDataCubit(userRepository: getIt<UserDataRepositoryImpl >()));

}

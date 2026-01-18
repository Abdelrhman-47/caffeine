import 'package:caffeine/core/constants/app_constats.dart';
import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/core/network/connectivity_cubit.dart';
import 'package:caffeine/core/network/connectivity_state.dart';
import 'package:caffeine/core/network/dio_clint.dart';
import 'package:caffeine/core/network/network_cheacker.dart';
import 'package:caffeine/core/sensetive_constatnts.dart';
import 'package:caffeine/features/auth/cubit/auth_cubit.dart';
import 'package:caffeine/features/auth/data/repo.dart';
import 'package:caffeine/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:caffeine/features/cart/data/cart_repo.dart';
import 'package:caffeine/features/details/cubit/real_price_cubit.dart';
import 'package:caffeine/features/details/data/details_repo.dart';
import 'package:caffeine/features/favorite/cubit/fav_cubit.dart';
import 'package:caffeine/features/favorite/data/fav_repo.dart';
import 'package:caffeine/features/home/cubits/offers_cubit/offers_cubit.dart';
import 'package:caffeine/features/home/cubits/product_cubit.dart';
import 'package:caffeine/features/home/data/local_service.dart';
import 'package:caffeine/features/home/data/product_repo.dart';
import 'package:caffeine/features/order/cubit/order_cubit.dart';
import 'package:caffeine/features/order/data/order_repo.dart';
import 'package:caffeine/features/profile/cubit/user_data_cubit.dart';
import 'package:caffeine/features/profile/data/local_service.dart';
import 'package:caffeine/features/profile/data/user_repo.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
    await FlutterPaymob.instance.initialize(
    apiKey:
        apiKeyPay,
    integrationID: integrationID, 
    walletIntegrationId: walletIntegrationId, 
    iFrameID: 991540, 
  );
  await Supabase.initialize(
    url: 'https://gaogtmhoavbrmblbbfwi.supabase.co',
    anonKey: AppConstats.annoneKey,
    authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
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
  getIt.registerLazySingleton<FavRepo>(
    () => FavRepoImpl(apiServices: getIt<ApiServices>()),
  );
  getIt.registerFactory<FavCubit>(() => FavCubit(favRepo: getIt<FavRepo>()));

  getIt.registerFactory<AuthCubit>(() => AuthCubit(user: getIt<UserRepo>()));
getIt.registerLazySingleton<LocalServiceProfile>(() => LocalServiceProfile());
  getIt.registerLazySingleton<UserDataRepositoryImpl>(
    () => UserDataRepositoryImpl(apiServices: getIt<ApiServices>(), localService: getIt<LocalServiceProfile>()),
  );
  getIt.registerFactory<UserDataCubit>(
    () => UserDataCubit(
      userRepository: getIt<UserDataRepositoryImpl>(),
      pref: getIt<PrefHelpers>(),
    ),
  );
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(apiServices: getIt<ApiServices>(), hiveService: getIt<HiveService>()),
  );

  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(productRepo: getIt<ProductRepo>()),
  );
  getIt.registerFactory<OffersCubit>(
    () => OffersCubit(productRepo: getIt<ProductRepo>()),
  );
    getIt.registerLazySingleton(() => NetworkChecker());

  getIt.registerLazySingleton<ConnectivityCubit>(
    () => ConnectivityCubit(networkChecker: getIt<NetworkChecker>()),
  );

  getIt.registerLazySingleton<DetailsRepo>(
    () => DetailsRepoImpl(apiServices: getIt<ApiServices>(), networkChecker: getIt<NetworkChecker>()),
  );
  getIt.registerFactory<RealPriceCubit>(
    () => RealPriceCubit(detailsRepo: getIt<DetailsRepo>()),
  );
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(apiServices: getIt<ApiServices>()),
  );
  getIt.registerFactory(() => CartCubit(cartRepo: getIt<CartRepo>()));
  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(apiServices: getIt<ApiServices>()),
  );
  getIt.registerFactory<OrderCubit>(
    () => OrderCubit(orderRepo: getIt<OrderRepo>()),
  );
}

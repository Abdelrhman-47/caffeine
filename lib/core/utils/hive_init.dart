import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';

class InitHive {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(OfferModelAdapter());
    Hive.registerAdapter(UserDataAdapter());

    await Hive.openBox<ProductModel>('productBox');
    await Hive.openBox<OfferModel>('offerBox');
    await Hive.openBox<UserData>('userDataBox');

  }
}
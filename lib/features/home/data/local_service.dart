import 'package:caffeine/features/home/data/product_model.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';

class InitHive {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(OfferModelAdapter());

    await Hive.openBox<ProductModel>('productBox');
    await Hive.openBox<OfferModel>('offerBox');
  }
}

class HiveService {
  static const String productBoxName = 'productBox';
  static const String offerBoxName = 'offerBox';

  Box<ProductModel> get _productBox =>
      Hive.box<ProductModel>(productBoxName);

  Box<OfferModel> get _offerBox =>
      Hive.box<OfferModel>(offerBoxName);

  // -------- Products --------

  List<ProductModel> getCachedProducts() {
    return _productBox.values.toList();
  }

  Future<void> cacheProducts(List<ProductModel> products) async {
    await _productBox.clear();
    for (var product in products) {
      _productBox.put(product.id, product);
    }
  }

  // -------- Offers --------

  List<OfferModel> getCachedOffers() {
    return _offerBox.values.toList();
  }

  Future<void> cacheOffers(List<OfferModel> offers) async {
    await _offerBox.clear();
    for (var offer in offers) {
      _offerBox.put(offer.id, offer);
    }
  }
}


import 'package:hive_ce/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int category;

  @HiveField(5)
  final String rate;

  ProductModel({
    required this.id,
    required this.url,
    required this.name,
    required this.price,
    required this.category,
    required this.rate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category'],
      rate: json['rate'],
    );
  }

  factory ProductModel.empty() {
    return ProductModel(
      id: 0,
      url: 'https://',
      name: '',
      price: 0.0,
      category: 0,
      rate: '',
    );
  }
}


@HiveType(typeId: 1)
class OfferModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String url1;

  @HiveField(2)
  final String? url2;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String des;

  @HiveField(5)
  final double price;

  OfferModel({
    required this.id,
    required this.name,
    required this.price,
    required this.url1,
    required this.des,
    this.url2,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      url1: json['url1'],
      url2: json['url2'],
      name: json['name'],
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      des: json['des'],
    );
  }
}

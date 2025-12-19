import 'package:caffeine/features/home/data/product_model.dart';

class CartModel {
  final int id;
  final DateTime createdAt;
  final int productId;
  final double realPrice;
  final String userId;
  final ProductModel product;

  CartModel({
    required this.id,
    required this.createdAt,
    required this.productId,
    required this.realPrice,
    required this.userId,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      productId: json['product_id'],
      realPrice: double.tryParse(json['real_price']?.toString() ?? '0') ?? 0.0,
      userId: json['user_id'],
      product: ProductModel.fromJson(json['products']),
    );
  }
}

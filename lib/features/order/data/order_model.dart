import 'package:caffeine/features/favorite/data/fav_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final int count;
  final num itemPrice;
  final int productId;
  final String userId;
  final num totalPrice;
  final ProductsModel product;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.count,
    required this.itemPrice,
    required this.productId,
    required this.userId,
    required this.totalPrice,
    required this.product,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      count: json['count'],
      itemPrice: json['item_price'],
      productId: json['product_id'],
      userId: json['user_id'],
      totalPrice: json['total_price'],
      product: ProductsModel.fromJson(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'count': count,
      'item_price': itemPrice,
      'product_id': productId,
      'user_id': userId,
      'total_price': totalPrice,
      'products': product.toJson(),
    };
  }
}

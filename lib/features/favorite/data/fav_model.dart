class FavModel {
  final int id;
  final String createdAt;
  final int productId;
  final String userId;
  final bool isFav;
  final ProductsModel product;

  FavModel({
    required this.id,
    required this.createdAt,
    required this.productId,
    required this.userId,
    required this.isFav,
    required this.product,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) {
    return FavModel(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      productId: json['product_id'] as int,
      userId: json['user_id'] as String,
      isFav: json['is_fav'] as bool,
      product: ProductsModel.fromJson(json['products'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'product_id': productId,
      'user_id': userId,
      'is_fav': isFav,
      'products': product.toJson(),
    };
  }
}

class ProductsModel {
  final int id;
  final String url;
  final String name;
  final String rate;
  final double price;
  final int category;
  final String createdAt;

  ProductsModel({
    required this.id,
    required this.url,
    required this.name,
    required this.rate,
    required this.price,
    required this.category,
    required this.createdAt,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'] as int,
      url: json['url'] as String,
      name: json['name'] as String,
      rate: json['rate'] as String,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category'] as int,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'rate': rate,
      'price': price,
      'category': category,
      'created_at': createdAt,
    };
  }
}

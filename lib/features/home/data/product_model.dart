class ProductModel {
  final int id;
  final String url;
  final String name;
  final double price;
  final int category;
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

class OfferModel {
  final String id;
  final String url1;
  final String? url2;
  final String name;
  final String des;
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
      url1: json['url1'],
      url2: json['url2'],
      name: json['name'],
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      des: json['des'],
      id: json['id'],
    );
  }
}

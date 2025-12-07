class ProductModel {
  final int id;
  final String url;
  final String name;
  final String price;
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
      price: json['price'],
      category: json['category'],
      rate: json['rate'],
    );
    }
  factory ProductModel.empty() {
    return ProductModel(
      id: 0,
      url: 'https://',
      name: '',
      price: '',
      category: 0,
      rate: '',
      );
    
         
  }
}

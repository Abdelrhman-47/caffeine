class PriceModel {
  final double realPrice;

  PriceModel({required this.realPrice});

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(realPrice: (json['real_price'] as num).toDouble());
  }
}

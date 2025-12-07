import 'package:caffeine/features/home/data/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}final class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  const ProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductFailure extends ProductState {
  final String errMessage;

  const ProductFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}


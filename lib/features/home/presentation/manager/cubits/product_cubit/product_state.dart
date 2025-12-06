part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}



final class ProductSuccess extends ProductState {
  final List<ProductModel> productModel;

  ProductSuccess({required this.productModel});
}
final class ProductFailure extends ProductState {
  final String errMessage;

  ProductFailure({required this.errMessage});
}
final class ProductFiltered extends ProductState{
  final List<ProductModel> filteredProducts;

  ProductFiltered(this.filteredProducts);
}

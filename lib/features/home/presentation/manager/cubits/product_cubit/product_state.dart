part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ToppingsLoading extends ProductState {}

final class OptionsLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductModel> productModel;

  ProductSuccess({required this.productModel});
}

final class ToppingsSuccess extends ProductState {
  final List<ToppingsModel> toppingsModel;

  ToppingsSuccess({required this.toppingsModel});
}

final class ToppingsFailure extends ProductState {
  final String errMessage;

  ToppingsFailure({required this.errMessage});
}

final class OptionsSuccess extends ProductState {
  final List<ToppingsModel> optionsModel;

  OptionsSuccess({required this.optionsModel});
}

final class OptionsFailure extends ProductState {
  final String errMessage;

  OptionsFailure({required this.errMessage});
}

final class ProductFailure extends ProductState {
  final String errMessage;

  ProductFailure({required this.errMessage});
}
final class ProductFiltered extends ProductState{
  final List<ProductModel> filteredProducts;

  ProductFiltered(this.filteredProducts);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/home/data/models/toppings_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import '../../../../data/models/product_model.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo) : super(ProductInitial());
  final ProductRepo productRepo;
  List<ProductModel> _allProducts = [];

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final productModel = await productRepo.getProducts();
      emit(ProductSuccess(productModel: productModel));
      _allProducts = productModel;
    } catch (e) {
      emit(ProductFailure(errMessage: e.toString()));
    }
  }

  Future<void> getToppings() async {
    emit(ToppingsLoading());
    try {
      final toppings = await productRepo.getToppings();

      emit(ToppingsSuccess(toppingsModel: toppings));
    } catch (e) {
      emit(ToppingsFailure(errMessage: e.toString()));
    }
  }

  Future<void> getOptions() async {
    emit(OptionsLoading());
    try {
      final options = await productRepo.getOptions();
      emit(OptionsSuccess(optionsModel: options));
    } catch (e) {
      emit(OptionsFailure(errMessage: e.toString()));
    }
  }
  void filterProducts(String query) {
    if (query.isEmpty) {
      emit(ProductSuccess(productModel: _allProducts));
      return;
    }

    final filtered = _allProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(ProductFiltered(filtered));
  }
}


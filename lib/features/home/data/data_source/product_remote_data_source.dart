import '../models/product_model.dart';
import '../models/toppings_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();

  Future<List<ToppingsModel>> getToppings();

  Future<List<ToppingsModel>> getOptions();

  Future<List<ProductModel>> searchProduct(String productName);
}

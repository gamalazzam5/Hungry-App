import 'package:hungry/features/home/data/data_source/product_remote_data_source_impl.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/toppings_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';

import '../data_source/product_remote_data_source.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepoImpl({required this.productRemoteDataSource});
  @override
  Future<List<ToppingsModel>> getOptions() async{
    return await productRemoteDataSource.getOptions();
  }

  @override
  Future<List<ProductModel>> getProducts() async{
   return await productRemoteDataSource.getProducts();
  }

  @override
  Future<List<ToppingsModel>> getToppings()async {
        return await productRemoteDataSource.getToppings();
  }

  @override
  Future<List<ProductModel>> searchProduct(String productName)async {
     return await productRemoteDataSource.searchProduct(productName);
  }

}
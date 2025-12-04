import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/home/data/data_source/product_remote_data_source.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/home/data/models/toppings_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ToppingsModel>> getOptions() async {
    try {
      final response = await apiService.get('/side-options');
      return (response['data'] as List)
          .map((topping) => ToppingsModel.fromJson(topping))
          .toList();
    } on DioException catch (e) {
      print("DIO ERROR: ${e.message}");
      return [];
    } catch (e) {
      print("UNEXPECTED ERROR: $e");
      return [];
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiService.get('/products/');
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } on DioException catch (e) {
      print("DIO ERROR: ${e.message}");
      return [];
    } catch (e) {
      print("UNEXPECTED ERROR: $e");
      return [];
    }
  }

  @override
  Future<List<ToppingsModel>> getToppings() async {
    try {
      final response = await apiService.get('/toppings');
      return (response['data'] as List)
          .map((topping) => ToppingsModel.fromJson(topping))
          .toList();
    } on DioException catch (e) {
      print("DIO ERROR: ${e.message}");
      return [];
    } catch (e) {
      print("UNEXPECTED ERROR: $e");
      return [];
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(String productName) async {
    try {
      final response = await apiService.get(
        '/products',
        queryParameters: {'name': productName},
      );
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } on DioException catch (e) {
      print("DIO ERROR: ${e.message}");
      return [];
    } catch (e) {
      print("UNEXPECTED ERROR: $e");
      return [];
    }
  }
}

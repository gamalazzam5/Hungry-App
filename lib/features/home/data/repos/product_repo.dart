import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/home/data/models/toppings_model.dart';

import '../../../../core/network/api_exceptions.dart';
import '../models/product_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.get('/products/');
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

  Future<List<ToppingsModel>> getToppings() async {
    try {
      final response = await _apiService.get('/toppings');
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
  Future<List<ToppingsModel>> getOptions() async {
    try {
      final response = await _apiService.get('/side-options');
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

  Future<List<ProductModel>> searchProduct(String productName)async {
    try{
      final response = await _apiService.get('/products',queryParameters:{'name':productName} );
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      } on DioException catch (e) {
      print("DIO ERROR: ${e.message}");
      return [];
    }
  }

}

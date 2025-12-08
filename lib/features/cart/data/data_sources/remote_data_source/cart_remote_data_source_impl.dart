import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiService apiService;

  CartRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      await apiService.post('/cart/add', data: cartData.toJson());
    } on DioException catch (e) {
      if(e is ApiError){
        ApiExceptions.handleError(e);
      }
      debugPrint("DIO ERROR: ${e.message}");
    } catch (e) {
      debugPrint("UNEXPECTED ERROR: $e");
    }
  }

  @override
  Future<GetCartResponse> getCartData() async {
    try {
      final response = await apiService.get('/cart');
      return GetCartResponse.fromJson(response);
    } catch (e) {
      if(e is DioException){
        ApiExceptions.handleError(e);
      }
      rethrow;
    }
  }

  @override
  Future<void> removeItemFromCart(int itemId) async {
    try {
      final response = await apiService.delete('/cart/remove/$itemId');
      debugPrint(response.toString());
    } catch (e) {
      if(e is ApiError){
        ApiExceptions.handleError(e.toString() as DioException);
      }
    }
  }
}

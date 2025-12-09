import 'package:flutter/cupertino.dart';
import 'package:hungry/core/network/api_service.dart';

import '../../models/Order_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> sendOrder(OrderModel orderModel);
}
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource{
 final ApiService apiService;

  OrderRemoteDataSourceImpl({required this.apiService});
  @override
  Future<void> sendOrder(OrderModel orderModel) async {
    try {
      final response = await apiService.post(
        '/orders',
        data: orderModel.toJson(),
      );
      debugPrint(response.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }


}
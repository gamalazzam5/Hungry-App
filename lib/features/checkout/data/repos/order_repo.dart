import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/checkout/data/models/Order_model.dart';

class OrderRepo {
  final ApiService _apiService = ApiService();

  Future<void> sendOrder(OrderModel orderModel) async {
    try {
      final response = await _apiService.post(
        '/orders',
        data: orderModel.toJson(),
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }
}

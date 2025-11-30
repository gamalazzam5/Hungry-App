import 'package:hungry/core/network/api_service.dart';

import '../models/order_history.dart';

class OrderHistoryRepo {
  ApiService apiService = ApiService();

  Future<List<OrderHistory>> getOrderHistory() async {
    try {
      final response = await apiService.get('/orders');
      List data = response['data'];
      print(response);
      return data.map((order) => OrderHistory.fromJson(order)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

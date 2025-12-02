import 'package:hungry/core/network/api_service.dart';
import '../models/Order_details.dart';
import '../models/order_history.dart';

class OrderHistoryRepo {
  final ApiService apiService = ApiService();

  Future<List<OrderDetails>> getOrderHistory() async {
    try {
      final response = await apiService.get('/orders');
      print("📌 Response Orders: $response");

      final List data = response['data'];

      // تحويل القائمة لموديل بسيط
      final List<OrderHistory> orders =
      data.map((order) => OrderHistory.fromJson(order)).toList();

      print("📌 Total Orders Found: ${orders.length}");

      // الطلبات تعمل Parallel Requests باستخدام Future.wait
      final List<OrderDetails> detailedOrders = await Future.wait(
        orders.map((order) async {
          print("🔄 Fetching Details For Order ID: ${order.id}");

          final detailsResponse =
          await apiService.get('/orders/${order.id}');

          print("📌 Order ${order.id} Details: $detailsResponse");

          return OrderDetails.fromJson(detailsResponse);
        }),
      );

      return detailedOrders;

    } catch (e) {
      print("🔥 Error in Repo: $e");
      return [];
    }
  }
}

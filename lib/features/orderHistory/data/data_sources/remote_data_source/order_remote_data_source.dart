import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/orderHistory/data/models/Order_history.dart';

import '../../models/Data.dart';

abstract class OrderHistoryRemoteDataSource {
  Future<List<Data>> getOrderHistory();
}
class OrderHistoryRemoteDataSourceImpl implements OrderHistoryRemoteDataSource {
  final ApiService apiService;

  OrderHistoryRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<Data>> getOrderHistory() async {
    final response = await apiService.get('/orders');
    final orderHistory  = OrderHistory.fromJson(response);
    return orderHistory.data??[];

}
}
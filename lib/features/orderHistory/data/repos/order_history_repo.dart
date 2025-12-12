import 'package:hungry/features/orderHistory/data/data_sources/remote_data_source/order_remote_data_source.dart';
import 'package:hungry/features/orderHistory/data/models/Data.dart';


abstract class OrderHistoryRepo {
  Future <List<Data>> getOrderHistory();
}
class OrderHistoryImpl implements OrderHistoryRepo {
  final OrderHistoryRemoteDataSource orderRemoteDataSource;

  OrderHistoryImpl({required this.orderRemoteDataSource});
  @override
  Future <List<Data>> getOrderHistory() async {
        return  await orderRemoteDataSource.getOrderHistory();
  }


}
import 'package:hungry/features/checkout/data/data_sources/remote_data_sources/order_remote_data_source.dart';

import '../models/Order_model.dart';

abstract class OrderRepo {
  Future<void> sendOrder(OrderModel orderModel);
}
class OrderRepoImpl implements OrderRepo{
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRepoImpl({required this.orderRemoteDataSource});
  @override
  Future<void> sendOrder(OrderModel orderModel) async {
      await orderRemoteDataSource.sendOrder(orderModel);
  }

}
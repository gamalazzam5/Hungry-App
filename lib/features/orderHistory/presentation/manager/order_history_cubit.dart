import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/orderHistory/data/repos/order_history_repo.dart';

import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit(this.orderHistoryRepo) : super(OrderHistoryInitial());
  final OrderHistoryRepo orderHistoryRepo;

  Future<void> getOrderHistory() async {
    emit(OrderHistoryLoading());
    try {
      final orders = await orderHistoryRepo.getOrderHistory();
      emit(OrderHistorySuccess(orders));
    } catch (e) {
      emit(OrderHistoryFailure(errMessage: e.toString()));
    }
  }
}

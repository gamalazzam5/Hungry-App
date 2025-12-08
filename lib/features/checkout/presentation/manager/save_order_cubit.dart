import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/checkout/presentation/manager/save_order_state.dart';

import '../../data/models/Order_model.dart';
import '../../data/repos/order_repo.dart';

class SaveOrderCubit extends Cubit<SaveOrderState> {
  SaveOrderCubit(this.orderRepo) : super(SaveOrderInitial());
  final OrderRepo orderRepo;
  Future<void> saveOrder(OrderModel orderModel) async {
    emit(SaveOrderLoading());
        try{
          await orderRepo.sendOrder(orderModel);
          emit(SaveOrderSuccess());
        }catch(e){
          emit(SaveOrderFailure(errMessage: e.toString()));
        }
  }
}

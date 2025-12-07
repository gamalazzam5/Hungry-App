import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final CartRepo cartRepo;

  GetCartCubit(this.cartRepo) : super(GetCartInitial());

  Future<void> getCartData() async {
    emit(GetCartLoading());
    try {
      final res = await cartRepo.getCartData();

      final quantities = List<int>.generate(res.data.items.length, (_) => 1);

      emit(GetCartSuccess(cartResponse: res, quantities: quantities));
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  void increment(int index) {
    final currentState = state;
    if (currentState is GetCartSuccess) {
      final newQuantities = List<int>.from(currentState.quantities);
      newQuantities[index]++;
      emit(currentState.copyWith(quantities: newQuantities));
    }
  }

  void decrement(int index) {
    final currentState = state;
    if (currentState is GetCartSuccess) {
      final newQuantities = List<int>.from(currentState.quantities);
      if (newQuantities[index] > 1) {
        newQuantities[index]--;
        emit(currentState.copyWith(quantities: newQuantities));
      }
    }
  }
}

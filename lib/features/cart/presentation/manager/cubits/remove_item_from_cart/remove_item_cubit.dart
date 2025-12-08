import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/remove_item_from_cart/remove_item_state.dart';

class RemoveItemCubit extends Cubit<RemoveItemState> {
  RemoveItemCubit(this.cartRepo) : super(RemoveItemInitial());
  final CartRepo cartRepo;

  Future<void> removeItemFromCart(int itemId) async {
    emit(RemoveItemLoading(itemId: itemId));
    try {
      await cartRepo.removeItemFromCart(itemId);
      emit(RemoveItemSuccess());
    } catch (e) {
      emit(RemoveItemFailure(errMessage: e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'get_cart_state.dart';
import '../../../../data/models/cart_model.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final CartRepo cartRepo;

  GetCartCubit(this.cartRepo) : super(GetCartInitial());

  // ============================
  // Load Cart
  // ============================
  Future<void> getCartData() async {
    emit(GetCartLoading());
    try {
      final res = await cartRepo.getCartData();

      final quantities = List<int>.generate(
        res.data.items.length,
            (_) => 1,
      );

      emit(GetCartSuccess(cartResponse: res, quantities: quantities));
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  // ============================
  // Increment
  // ============================
  void increment(int index) {
    final current = state;

    if (current is GetCartSuccess) {
      final updatedQuantities = List<int>.from(current.quantities);
      updatedQuantities[index]++;

      emit(current.copyWith(quantities: updatedQuantities));
    }
  }

  // ============================
  // Decrement
  // ============================
  void decrement(int index) {
    final current = state;

    if (current is GetCartSuccess) {
      final updatedQuantities = List<int>.from(current.quantities);

      if (updatedQuantities[index] > 1) {
        updatedQuantities[index]--;
        emit(current.copyWith(quantities: updatedQuantities));
      }
    }
  }

  // ============================
  // Remove Item LOCAL
  // ============================
  void removeItemLocal(int index) {
    final current = state;

    if (current is GetCartSuccess) {
      // قائمة جديدة من العناصر
      final updatedItems = List<CartItemModel>.from(
        current.cartResponse.data.items,
      );

      // حذف العنصر
      updatedItems.removeAt(index);

      // قائمة الكميات
      final updatedQuantities = List<int>.from(current.quantities);
      updatedQuantities.removeAt(index);


      final updatedCartData =
      current.cartResponse.data.copyWithNewItems(updatedItems);

      // تحديث GetCartResponse
      final updatedResponse =
      current.cartResponse.copyWith(data: updatedCartData);

      // Emit final state
      emit(
        current.copyWith(
          cartResponse: updatedResponse,
          quantities: updatedQuantities,
        ),
      );
    }
  }
}

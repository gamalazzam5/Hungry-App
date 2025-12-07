import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';

import '../../../cart/data/models/cart_model.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit(this.cartRepo) : super(AddToCartInitial());
  final CartRepo cartRepo;

  Future<void> addToCart(CartRequestModel cartData) async {
    emit(AddToCartLoading());
    try {
      await cartRepo.addToCart(cartData);
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartFailure(e.toString()));
    }
  }
}

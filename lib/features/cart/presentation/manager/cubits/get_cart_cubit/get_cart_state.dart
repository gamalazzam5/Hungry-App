import '../../../../data/models/cart_model.dart';

abstract class GetCartState {}

class GetCartInitial extends GetCartState {}

class GetCartLoading extends GetCartState {}

class GetCartSuccess extends GetCartState {
  final GetCartResponse cartResponse;
  final List<int> quantities;

  GetCartSuccess({required this.cartResponse, required this.quantities});

  double get total {
    double total = 0;
    for (int i = 0; i < cartResponse.data.items.length; i++) {
      final price =
          double.tryParse(cartResponse.data.items[i].price.toString()) ?? 0;
      total += price * quantities[i];
    }
    return total;
  }

  GetCartSuccess copyWith({
    GetCartResponse? cartResponse,
    List<int>? quantities,
  }) {
    return GetCartSuccess(
      cartResponse: cartResponse ?? this.cartResponse,
      quantities: quantities ?? this.quantities,
    );
  }
}

class GetCartFailure extends GetCartState {
  final String errMessage;

  GetCartFailure(this.errMessage);
}

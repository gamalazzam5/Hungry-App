
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}
final class AddToCartLoading extends AddToCartState {}
final class AddToCartSuccess extends AddToCartState {}
final class AddToCartFailure extends AddToCartState {
  final String errMessage;

  AddToCartFailure(this.errMessage);
}


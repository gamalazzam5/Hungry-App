import '../../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<void> addToCart(CartRequestModel cartData);

  Future<GetCartResponse> getCartData();

  Future<void> removeItemFromCart(int itemId);
}
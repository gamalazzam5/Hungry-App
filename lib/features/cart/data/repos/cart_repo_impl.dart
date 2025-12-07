import 'package:hungry/features/cart/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';

import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepoImpl({required this.cartRemoteDataSource});

  @override
  Future<void> addToCart(CartRequestModel cartData) async {
    await cartRemoteDataSource.addToCart(cartData);
  }

  @override
  Future<GetCartResponse> getCartData() async {
    return await cartRemoteDataSource.getCartData();
  }

  @override
  Future<void> removeItemFromCart(int itemId) async {
    await cartRemoteDataSource.removeItemFromCart(itemId);
  }
}

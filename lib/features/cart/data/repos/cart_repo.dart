import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/models/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();

  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final response = await _apiService.post(
        '/cart/add',
        data: cartData.toJson(),
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }
Future<GetCartResponse> getCartData()async{
    try{
      final response = await _apiService.get('/cart');
      return GetCartResponse.fromJson(response);
      }catch(e){
      print(e);
      rethrow;
    }
}
}

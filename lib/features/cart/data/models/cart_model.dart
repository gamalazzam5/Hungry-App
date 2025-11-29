class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}

class CartRequestModel {
  final List<CartModel> cartItems;

  CartRequestModel({required this.cartItems});

  Map<String, dynamic> toJson() {
    return {'items': cartItems.map((item) => item.toJson()).toList()};
  }
}

class GetCartResponse {
  final int code;
  final String message;
  final CartData data;

  GetCartResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      code: json['code']??200,
      message: json['message'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final int id;
  final String totalPrice;
  final List<CartItemModel> items;

  CartData({required this.id, required this.totalPrice, required this.items});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      totalPrice: json['total_price'],
      items: (json['items'] as List).map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }
}

class CartItemModel {
  final int itemId;
  final int productId;
  final String image;
  final String name;
  final String price;
  final int quantity;
  final String spicy;
  final List<CartToppings> toppings;
  final List<CartOptions> sideOptions;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['item_id']??0,
      productId: json['product_id']??0,
      image: json['image']??'',
      name: json['name']??'',
      price: json['price']??'0',
      quantity: json['quantity']??"",
      spicy: json['spicy'].toString()??'',
      toppings: (json['toppings'] as List)
          .map((e) => CartToppings.fromJson(e))
          .toList(),
      sideOptions: (json['side_options'] as List)
          .map((e) => CartOptions.fromJson(e))
          .toList(),
    );
  }
}

class CartToppings {
  final int id;
  final String name;
  final String image;

  CartToppings({required this.id, required this.name, required this.image});

  factory CartToppings.fromJson(Map<String, dynamic> json) {
    return CartToppings(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class CartOptions {
  final int id;
  final String name;
  final String image;

  CartOptions({required this.id, required this.name, required this.image});

  factory CartOptions.fromJson(Map<String, dynamic> json) {
    return CartOptions(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

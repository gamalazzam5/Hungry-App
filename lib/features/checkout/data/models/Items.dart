class Items {
  Items({
    this.productId,
    this.quantity,
    this.spicy,
    this.toppings,
    this.sideOptions,
  });

  Items.fromJson(dynamic json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    spicy = json['spicy'];
    toppings = json['toppings'] != null ? json['toppings'].cast<int>() : [];
    sideOptions = json['side_options'] != null
        ? json['side_options'].cast<int>()
        : [];
  }

  int? productId;
  int? quantity;
  double? spicy;
  List<int>? toppings;
  List<int>? sideOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['spicy'] = spicy;
    map['toppings'] = toppings;
    map['side_options'] = sideOptions;
    return map;
  }
}

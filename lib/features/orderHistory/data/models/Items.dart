import 'Toppings.dart';
import 'SideOptions.dart';

class Items {
  Items({
    this.productId,
    this.name,
    this.image,
    this.quantity,
    this.price,
    this.spicy,
    this.toppings,
    this.sideOptions,
  });

  Items.fromJson(dynamic json) {
    productId = json['product_id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    spicy = json['spicy'];
    if (json['toppings'] != null) {
      toppings = [];
      json['toppings'].forEach((v) {
        toppings?.add(Toppings.fromJson(v));
      });
    }
    if (json['side_options'] != null) {
      sideOptions = [];
      json['side_options'].forEach((v) {
        sideOptions?.add(SideOptions.fromJson(v));
      });
    }
  }

  int? productId;
  String? name;
  String? image;
  int? quantity;
  String? price;
  String? spicy;
  List<Toppings>? toppings;
  List<SideOptions>? sideOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['name'] = name;
    map['image'] = image;
    map['quantity'] = quantity;
    map['price'] = price;
    map['spicy'] = spicy;
    if (toppings != null) {
      map['toppings'] = toppings?.map((v) => v.toJson()).toList();
    }
    if (sideOptions != null) {
      map['side_options'] = sideOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

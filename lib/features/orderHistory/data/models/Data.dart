import 'Items.dart';

class Data {
  Data({
      this.id, 
      this.status, 
      this.totalPrice, 
      this.createdAt, 
      this.items,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? id;
  String? status;
  String? totalPrice;
  String? createdAt;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['total_price'] = totalPrice;
    map['created_at'] = createdAt;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
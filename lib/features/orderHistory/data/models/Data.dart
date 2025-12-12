class Data {
  Data({
      this.id, 
      this.status, 
      this.totalPrice, 
      this.createdAt, 
      this.productImage,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    productImage = json['product_image'];
  }
  int? id;
  String? status;
  String? totalPrice;
  String? createdAt;
  String? productImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['total_price'] = totalPrice;
    map['created_at'] = createdAt;
    map['product_image'] = productImage;
    return map;
  }

}
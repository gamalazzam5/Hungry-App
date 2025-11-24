class ProductModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final String desc;
  final String rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.desc,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: json['price'].toString(),
      image: json['image'] ?? '',
      desc: json['description'] ?? '',
      rating: json['rating']?.toString() ?? '0',
    );
  }

}

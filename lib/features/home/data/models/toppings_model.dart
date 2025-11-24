class ToppingsModel {
  final int id;
  final String image;
  final String name;

  ToppingsModel({required this.image, required this.name,required this.id});

  factory ToppingsModel.fromJson(Map<String, dynamic> json) {
    return ToppingsModel(image: json['image'], name: json['name'], id: json['id']);
  }
}

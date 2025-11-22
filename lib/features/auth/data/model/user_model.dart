class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? address;
  final String? visa;
  final String? token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.visa,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        image: json["image"] ?? '',
        address: json["address"] ?? 'Samannud',
        visa: json["Visa"],
        token: json["token"] ?? '',
      );
}

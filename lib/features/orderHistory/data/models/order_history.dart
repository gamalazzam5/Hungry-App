class OrderHistory {
  final int id;
  final String status;
  final String createdAt;
  final String totalPrice;
  final String image;

  OrderHistory({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.totalPrice,
    required this.image,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      status: json['status'],
      createdAt: json['created_at'],
      totalPrice: json['total_price'],
      image: json['product_image'],
    );
  }
}

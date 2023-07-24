class OrderListModel {
  final int id;
  final List<OrderItemModel> items;
  final String userId;
  final String userName;
  final String userPhone;
  final String? userEmail;
  final DateTime createdAt;
  final String deliveryId;
  final String deliveryType;
  final String deliveryName;
  final double deliveryPrice;
  final DateTime? deliveryDate;
  final String paymentId;
  final String paymentType;
  final String paymentName;
  final double itemsPrice;
  final int discount;
  final double fullPrice;
  final String? promocode;
  final String? address;
  final String? comment;
  final String? errorText;
  final String brand;
  final int status;
  final int repeatedDays;

  OrderListModel({
    required this.id,
    required this.items,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.createdAt,
    required this.deliveryId,
    required this.deliveryType,
    required this.deliveryName,
    required this.deliveryPrice,
    required this.deliveryDate,
    required this.paymentId,
    required this.paymentType,
    required this.paymentName,
    required this.itemsPrice,
    required this.discount,
    required this.fullPrice,
    required this.promocode,
    required this.address,
    required this.comment,
    required this.errorText,
    required this.brand,
    required this.status,
    required this.repeatedDays,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      id: json['id'],
      items: List<OrderItemModel>.from(json['items'].map((item) => OrderItemModel.fromJson(item))),
      userId: json['user_id'].toString(),
      userName: json['user_name'],
      userPhone: json['user_phone'].toString(),
      userEmail: json['user_email'],
      createdAt: DateTime.parse(json['created_at']),
      deliveryId: json['delivery_id'].toString(),
      deliveryType: json['delivery_type'],
      deliveryName: json['delivery_name'],
      deliveryPrice: double.parse(json['delivery_price'].toString()),
      deliveryDate: json['delivery_date'] != null ? DateTime.parse(json['delivery_date']) : null,
      paymentId: json['payment_id'].toString(),
      paymentType: json['payment_type'],
      paymentName: json['payment_name'],
      itemsPrice: double.parse(json['items_price'].toString()),
      discount: json['discount'],
      fullPrice: double.parse(json['full_price'].toString()),
      promocode: json['promocode'],
      address: json['address'],
      comment: json['comment'],
      errorText: json['error_text'],
      brand: json['brand'],
      status: json['status'],
      repeatedDays: json['repeated_days'],
    );
  }
}

class OrderItemModel {
  final int id;
  final String name;
  final String picture;
  final int count;
  final double price;
  final dynamic discount;
  final int order;
  final int product;

  OrderItemModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.count,
    required this.price,
    required this.discount,
    required this.order,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      count: json['count'],
      price: double.parse(json['price'].toString()),
      discount: json['discount'],
      order: json['order'],
      product: json['product'],
    );
  }
}

class CartResponse {
  String price;
  String oldPrice;
  int count;
  List<CartProduct> products;

  CartResponse({
    required this.price,
    required this.oldPrice,
    required this.count,
    required this.products,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      price: json['price'],
      oldPrice: json['old_price'],
      count: json['count'],
      products: List<CartProduct>.from(
          json['products'].map((product) => CartProduct.fromJson(product))),
    );
  }
}

class CartProduct {
  int count;
  CatalogProduct product;

  CartProduct({
    required this.count,
    required this.product,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      count: json['count'],
      product: CatalogProduct.fromJson(json['product']),
    );
  }
}

class CatalogProduct {
  int id;
  String price;
  String? oldPrice;
  String discount;
  String name;
  String brand;
  String picture;
  String article;
  List<dynamic> badges; // You can create a model class for badges if needed
  double? rating;
  int reviewsCount;

  CatalogProduct({
    required this.id,
    required this.price,
    this.oldPrice,
    required this.discount,
    required this.name,
    required this.brand,
    required this.picture,
    required this.article,
    required this.badges,
    this.rating,
    required this.reviewsCount,
  });

  factory CatalogProduct.fromJson(Map<String, dynamic> json) {
    return CatalogProduct(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      name: json['name'],
      brand: json['brand'],
      picture: json['picture'],
      article: json['article'],
      badges: json['badges'],
      rating: json['rating']?.toDouble(),
      reviewsCount: json['reviews_count'],
    );
  }
}

class Favorite {
  final int id;
  final String price;
  final String? oldPrice;
  final String discount;
  final String name;
  final String brand;
  final String picture;
  final String article;
  final List<Badge> badges;
  final double? rating;
  final int reviewsCount;

  Favorite({
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

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      name: json['name'],
      brand: json['brand'],
      picture: json['picture'],
      article: json['article'],
      badges: List<Badge>.from(json['badges'].map((badge) => Badge.fromJson(badge))),
      rating: json['rating'],
      reviewsCount: json['reviews_count'],
    );
  }
}

class Badge {
  final int id;
  final String? textColor;
  final String? bgColor;
  final String? text;
  final String? picture;

  Badge({
    required this.id,
    this.textColor,
    this.bgColor,
    this.text,
    this.picture,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      textColor: json['text_color'],
      bgColor: json['bg_color'],
      text: json['text'],
      picture: json['picture'],
    );
  }
}

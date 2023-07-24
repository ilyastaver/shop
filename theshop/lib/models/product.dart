import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final List<ProductProperty> parameters;
  final String picture;
  final List<Category> categories;
  final List<Badge> badges;
  final String price;
  final String oldPrice;
  final String brand;
  final String article;
  final String name;
  final String description;
  final bool available;
  final num discount;
  final int sort;
  final num rating;
  final int reviewsCount;
  final int needBuyToWholesale;
  final int wholesaleDiscount;

  Product({
    required this.id,
    required this.title,
    required this.parameters,
    required this.picture,
    required this.categories,
    required this.badges,
    required this.price,
    required this.oldPrice,
    required this.brand,
    required this.article,
    required this.name,
    required this.description,
    required this.available,
    required this.discount,
    required this.sort,
    required this.rating,
    required this.reviewsCount,
    required this.needBuyToWholesale,
    required this.wholesaleDiscount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    parameters,
    picture,
    categories,
    badges,
    price,
    oldPrice,
    brand,
    article,
    name,
    description,
    available,
    discount,
    sort,
    rating,
    reviewsCount,
    needBuyToWholesale,
    wholesaleDiscount,
  ];
}

class ProductProperty {
  final int id;
  final String name;
  final String value;
  final int product;

  ProductProperty({
    required this.id,
    required this.name,
    required this.value,
    required this.product,
  });
}

class Category {
  final int id;
  final String name;
  final String picture;

  Category({
    required this.id,
    required this.name,
    required this.picture,
  });
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
}

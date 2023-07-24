import 'package:equatable/equatable.dart';
import 'package:theshop/models/product.dart';

class AppState extends Equatable {
  List<Product> favoriteProducts;

  int favoriteCount;

  AppState({required this.favoriteProducts, this.favoriteCount = 0});

  @override
  List<Object?> get props => [favoriteProducts];
}

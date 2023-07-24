import 'package:theshop/models/product.dart';

class AddToFavoriteAction {
  final Product product;

  AddToFavoriteAction({required this.product});
}

class RemoveFromFavoriteAction {
  final int productId;

  RemoveFromFavoriteAction({required this.productId});
}

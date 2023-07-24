import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:theshop/models/product.dart';
import 'package:theshop/redux/actions.dart';
import 'package:theshop/redux/app_state.dart';

class CardImage extends StatefulWidget {
  final Product product;

  const CardImage({required this.product, Key? key}) : super(key: key);

  @override
  _CardImageState createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checked = _isProductInFavorites();
  }

  bool _isProductInFavorites() {
    final List<Product> favoriteProducts = StoreProvider.of<AppState>(context).state.favoriteProducts;
    return favoriteProducts.contains(widget.product);
  }

  void _toggleFavorite() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    if (checked) {
      store.dispatch(RemoveFromFavoriteAction(productId: widget.product.id));
    } else {
      store.dispatch(AddToFavoriteAction(product: widget.product));
    }
    setState(() {
      checked = !checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: widget.product.picture,
          fit: BoxFit.fill,
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: checked
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border, color: Color(0xFF7d7d7d)),
          onPressed: _toggleFavorite,
        ),
      ],
    );
  }
}

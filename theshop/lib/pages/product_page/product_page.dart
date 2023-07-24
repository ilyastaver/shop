import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:theshop/models/product.dart';
import 'package:theshop/widgets/cart_button.dart';

import '../../redux/actions.dart';
import '../../redux/app_state.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _checked = false;
  bool _isFavorite = false;
  int _counter = 0;

  void _handleCartButtonTap() {
    print('Cart button pressed!');
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _isFavorite = _isProductInFavorites();
      });
    });
  }

  bool _isProductInFavorites() {
    final List<Product> favoriteProducts = StoreProvider.of<AppState>(context).state.favoriteProducts;
    return favoriteProducts.contains(widget.product);
  }

  void _toggleFavorite() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    if (_isFavorite) {
      store.dispatch(RemoveFromFavoriteAction(productId: widget.product.id));
    } else {
      store.dispatch(AddToFavoriteAction(product: widget.product));
    }
    setState(() {
      _checked = !_checked;
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Страница товара',
          style: theme.textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView( // Use ListView instead of Column
            children: [
              Row(
                children: [
                  Text(
                    '${widget.product.discount}%',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 18),
                  ),
                  const Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: _isFavorite
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border, color: Color(0xFF7d7d7d)),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: CachedNetworkImage(imageUrl: widget.product.picture),
                ),
              ),
              Container(
                child: Text(
                  widget.product.title,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    widget.product.price,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.product.oldPrice,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 18, color: Colors.grey, decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    color: Colors.black,
                    child: CartButton(
                      onPressed: _handleCartButtonTap,
                      counter: _counter,
                      onCounterChanged: (newCounter) {
                        setState(() {
                          _counter = newCounter;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildDescriptionAndCharacteristics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionAndCharacteristics() {
    return ExpansionTile(
      title: const Row(
        children: [
          Text(
            'Описание и характеристики',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Общее описание:'),
              Expanded(
                child: Text(
                  widget.product.name,
                  textAlign: TextAlign.end,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Бренд:'),
              Expanded(
                child: Text(
                  widget.product.brand,
                  textAlign: TextAlign.end,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ],
      onExpansionChanged: (value) {
        setState(() {
          _checked = value;
        });
      },
    );
  }

}

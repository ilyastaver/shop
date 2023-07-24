import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:theshop/widgets/card_image.dart';
import 'package:theshop/my_flutter_app_icons.dart';

import '../api/cart/api_service.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool checked = false;
  final CartApiService _cartApiService = CartApiService();
  bool addedToCart = false;

  Future<void> addProductToCart(int productId) async {
    try {
      await _cartApiService.addProductToCart(productId);

    } catch (e) {
      setState(() {
        addedToCart = true;
      });
      print('Already in cart');
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(
      children: [
        CardImage(product: widget.product),
        const SizedBox(height: 3,),
        SizedBox(
          height: 32,
          child: Text(
            widget.product.name,
            style: textTheme.bodySmall?.copyWith(color: colorTheme.secondary),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 3,),
        Row(
          children: [
            Column(
              children: [
                Text(
                  widget.product.price,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorTheme.onSurface),
                ),
                Text(
                  widget.product.oldPrice,
                  style: textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: colorTheme.onSurface,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (addedToCart)
              const Text(
                'В корзине',
                style: TextStyle(color: Colors.green),
              )
            else
              FloatingActionButton(
                onPressed: () {
                  addProductToCart(widget.product.id);
                },
                backgroundColor: colorTheme.onPrimary,
                elevation: 0,
                child: const Icon(
                  MyFlutterApp.korzina,
                  size: 30,
                ),
              ),
          ],
        )
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:theshop/models/cart.dart';
import 'package:theshop/my_flutter_app_icons.dart';

import '../models/product.dart';
import '../api/cart/api_service.dart';

class CartItem extends StatefulWidget {
  final CatalogProduct product;
  final Function() onDelete;
  int productCount;

  CartItem({
    required this.product,
    required this.onDelete,
    required this.productCount,
  });

  @override
  State<CartItem> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {

  void _updateCartItemCount(BuildContext context) async {
    try {
      CartApiService apiService = CartApiService();
      await apiService.updateCartItem(widget.product.id, widget.productCount);
      widget.onDelete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update item count.'),
      ));
    }
  }

  void _incrementCounter() {
    setState(() {
      widget.productCount++;
    });
    _updateCartItemCount(context);
  }

  void _decrementCounter() {
    if (widget.productCount > 1) {
      setState(() {
        widget.productCount--;
      });
      _updateCartItemCount(context);
    }
  }

  void _onDeletePressed(BuildContext context) async {
    CartApiService apiService = CartApiService();
    try {
      await apiService.deleteCartItem(widget.product.id);
      widget.onDelete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to delete item.'),
      ));
    }
  }

  String _formatPrice(String? price) {
    if (price == null) {
      return '';
    }

    final double parsedPrice = double.tryParse(price) ?? 0.0;

    final formattedPrice = parsedPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.0*$'), '');

    return '$formattedPrice₽';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: widget.product.picture,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textScaleFactor: 0.9,
                    ),
                  ),

                  Column(
                    children: [
                      IconButton(

                        icon: const Icon(Icons.clear),
                        onPressed: () => _onDeletePressed(context),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrementCounter,
                          ),
                          Text(
                            widget.productCount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _incrementCounter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                _formatPrice(widget.product.price),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (widget.product.oldPrice != null)
                Text(
                  _formatPrice(widget.product.oldPrice),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/order.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderListModel order;

  const OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали заказа'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final item = order.items[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: item.picture,
              width: 50,
              height: 50,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(item.name),
            subtitle: Text(' ${item.price}'),
          );
        },
      ),
    );
  }
}

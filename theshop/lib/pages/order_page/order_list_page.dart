import 'package:flutter/material.dart';
import 'package:theshop/api/order/api_service.dart';


import '../../models/order.dart';
import 'order_details_page.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final OrderApiService _orderApiService = OrderApiService();
  late Future<List<OrderListModel>> _orderListFuture;

  @override
  void initState() {
    super.initState();
    _fetchOrderList();
  }

  Future<void> _fetchOrderList() async {
    setState(() {
      _orderListFuture = _orderApiService.fetchOrderList();
    });
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildOrderList(List<OrderListModel> orderList) {
    return ListView.builder(
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        final order = orderList[index];
        return ListTile(
          title: Text('ID Заказа: ${order.id}'),
          subtitle: Text('Создан: ${order.createdAt}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsPage(order: order),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<OrderListModel>>(
        future: _orderListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildPlaceholder();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching order list'),
            );
          } else {
            final orderList = snapshot.data;
            if (orderList != null && orderList.isNotEmpty) {
              return _buildOrderList(orderList);
            } else {
              return const Center(
                child: Text('No orders found.'),
              );
            }
          }
        },
      ),
    );
  }
}

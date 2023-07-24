import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:theshop/api/order/url.dart';

import '../../models/order.dart';

class OrderApiService {


  OrderApiService();

  Future<void> placeOrder({
    required List<Map<String, dynamic>> products,
    required String userName,
    required String userPhone,
    required String deliveryId,
    required String deliveryType,
    required String paymentId,
    required String paymentType,
  }) async {
    final Map<String, dynamic> requestBody = {
      "products": products,
      "user_name": userName,
      "user_phone": userPhone,
      "delivery_id": deliveryId,
      "delivery_type": deliveryType,
      "payment_id": paymentId,
      "payment_type": paymentType,
    };

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.baseUrl),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Order placed successfully');
      } else {
        throw Exception('Failed to place the order. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error placing order: $e');
      throw Exception('Failed to place the order.');
    }
  }

  Future<List<OrderListModel>> fetchOrderList() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.orderListUrl),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        final List<OrderListModel> orderList = data.map((item) => OrderListModel.fromJson(item)).toList();
        return orderList;
      } else {
        throw Exception('Failed to fetch order list. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order list: $e');
      throw Exception('Failed to fetch order list.');
    }
  }

}

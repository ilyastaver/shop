import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/cart.dart';
import 'url.dart';

class CartApiService {


  Future<CartResponse> getCartData() async {
    try {
      final response = await http.post(
          Uri.parse('${ApiUrls.baseUrl}${ApiUrls.calculateCart}'),
          headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
          'Content-Type': 'application/json'},);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return CartResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> deleteCartItem(int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiUrls.baseUrl}${ApiUrls.addToCart}'),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'product_id': productId}),
      );
      if (response.statusCode == 200) {

      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> addProductToCart(int productId) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiUrls.baseUrl}${ApiUrls.addToCart}'),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'product_id': productId, "city_fias": "string"}),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> updateCartItem(int productId, int count) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiUrls.baseUrl}${ApiUrls.addToCart}'),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'product_id': productId, 'count': count}),
      );
      if (response.statusCode == 200) {

      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

}

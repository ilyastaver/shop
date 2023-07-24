import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:theshop/models/product.dart';
import 'url.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.baseUrl),
        headers: {
          'Authorization': 'Bearer ${ApiUrls.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> results = jsonData['results'];
        return results.map((data) => _convertToProduct(data)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Product _convertToProduct(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? 0,
      title: data['name'] ?? '',
      parameters: _convertToProductProperties(data['parameters'] ?? []),
      picture: data['picture'] ?? '',
      categories: _convertToCategories(data['categories'] ?? []),
      badges: _convertToBadges(data['badges'] ?? []),
      price: _formatPrice(data['price'])?? '',
      oldPrice: _formatPrice(data['old_price'])?? '',
      brand: data['brand'] ?? '',
      article: data['article'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      available: data['available'] ?? true,
      discount: data['discount'] ?? 0.0,
      sort: data['sort'] ?? 0,
      rating: data['rating'] ?? 0.0,
      reviewsCount: data['reviews_count'] ?? 0,
      needBuyToWholesale: data['need_buy_to_wholesale'] ?? 0,
      wholesaleDiscount: data['wholesale_discount'] ?? 0,
    );
  }
  String _formatPrice(String? price) {
    if (price == null) {
      return '';
    }

    final double parsedPrice = double.tryParse(price) ?? 0.0;

    final formattedPrice = parsedPrice.toStringAsFixed(2).replaceAll(RegExp(r'\.0*$'), '');

    return '$formattedPrice₽';
  }


  List<ProductProperty> _convertToProductProperties(List<dynamic> properties) {
    return properties.map((data) => ProductProperty(
      id: data['id'],
      name: data['name'],
      value: data['value'],
      product: data['product'],
    )).toList();
  }

  List<Category> _convertToCategories(List<dynamic> categories) {
    return categories.map((data) => Category(
      id: data['id'],
      name: data['name'],
      picture: data['picture'],
    )).toList();
  }

  List<Badge> _convertToBadges(List<dynamic> badges) {
    return badges.map((data) => Badge(
      id: data['id'],
      textColor: data['textColor'],
      bgColor: data['bgColor'],
      text: data['text'],
      picture: data['picture'],
    )).toList();
  }
}

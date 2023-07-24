import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:theshop/api/deliveries/url.dart';

import '../../models/deliveries.dart';

class DeliveriesApiService {
  final String baseUrl = 'https://farm.fbtw.ru/deliveries/deliveries/';

  Future<List<DeliveryOption>> fetchDeliveryOptions() async {
    final response = await http.post(Uri.parse(ApiUrls.baseUrl),
      headers: {
        'Authorization': 'Bearer ${ApiUrls.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      return data.map((json) => DeliveryOption.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch delivery options');
    }
  }
}

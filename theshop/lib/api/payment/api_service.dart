import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:theshop/api/payment/url.dart';

import '../../models/payment.dart';

class PaymentApiService {


  Future<List<PaymentOption>> fetchPaymentOptions() async {
    final response = await http.post(Uri.parse(ApiUrls.baseUrl),
      headers: {
      'Authorization': 'Bearer ${ApiUrls.token}',
      'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      return data.map((json) => PaymentOption.fromJson(json)).toList();
    } else {
      print('Error response: ${response.body}');
      throw Exception('Failed to fetch payment options');
    }
  }
}

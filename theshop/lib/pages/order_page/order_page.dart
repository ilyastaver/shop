import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theshop/api/deliveries/api_service.dart';
import 'package:theshop/api/payment/api_service.dart';
import 'package:theshop/models/cart.dart';

import '../../api/order/api_service.dart';
import '../../models/deliveries.dart';
import '../../models/payment.dart';
import '../../widgets/fill_button.dart';

@RoutePage()
class OrderPage extends StatefulWidget {
  final List<CartProduct> selectedOrder;
  const OrderPage({Key? key, required this.selectedOrder}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final PaymentApiService _paymentApiService = PaymentApiService();
  final DeliveriesApiService _deliveryApiService = DeliveriesApiService();
  final OrderApiService _orderApiService = OrderApiService();

  bool send = false;

  List<PaymentOption> _paymentOptions = [];
  List<DeliveryOption> _deliveryOptions = [];

  late String _paymentOptionId = '';
  late String _paymentOptionType = '';

  late String _selectedDeliveryOptionId = '';
  late String _selectedDeliveryOptionType = '';

  String _name = '';
  String _phoneNumber = '';
  String _countryCode = '7';

  var _selectedDeliveryIndex;
  var _selectedPaymentIndex;

  @override
  void initState() {
    super.initState();
    _fetchData();
    print(widget.selectedOrder);
  }

  Future<void> _fetchData() async {
    try {
      final paymentOptions = await _paymentApiService.fetchPaymentOptions();
      final deliveryOptions = await _deliveryApiService.fetchDeliveryOptions();
      setState(() {
        _paymentOptions = paymentOptions;
        _deliveryOptions = deliveryOptions;
      });
    } catch (e) {
      print('Error fetching data: $e');
      if (e is Exception) {
        print('Error response: ${e}');
      }
    }
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
          'Оформление заказа',
          style: theme.textTheme.bodyLarge,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Способы оплаты',
              style: theme.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: _paymentOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final paymentOption = entry.value;
              final isSelected = _selectedPaymentIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPaymentIndex = index;
                      _paymentOptionId = paymentOption.id;
                      _paymentOptionType = paymentOption.type;
                      print(_paymentOptionId);
                      print(_paymentOptionType);
                    });
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          color: isSelected ? Colors.grey[300] : Colors.transparent,
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            paymentOption.icon,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      Text(paymentOption.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Способы доставки',
              style: theme.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: _deliveryOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final deliveryOption = entry.value;
              final isSelected = _selectedDeliveryIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedDeliveryIndex = index;
                      _selectedDeliveryOptionId = deliveryOption.id;
                      _selectedDeliveryOptionType = deliveryOption.type;
                      print(_selectedDeliveryOptionId);
                      print(_selectedDeliveryOptionType);
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        color: isSelected ? Colors.grey[300] : Colors.transparent,
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          deliveryOption.icon,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(deliveryOption.title),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Имя пользователя',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _countryCode,
                  onChanged: (value) {
                    setState(() {
                      _countryCode = value!;
                    });
                  },
                  items: ['7', '8'].map((code) {
                    return DropdownMenuItem<String>(
                      value: code,
                      child: Text(code),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      if (!RegExp(r'^\+7\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid Russian phone number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (send == false)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Container(
                color: Colors.black,
                child: FillButton(
                  onPressed: () => _placeOrder(),
                  buttonName: 'ЗАКАЗАТЬ',
                ),
              ),
            ),
          ),
          if (send == true)
            const SizedBox(height: 15,),
            const Center(child: Text('Заказ отправлен'))
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    setState(() {
      send = true;
    });

    try {
      final products = widget.selectedOrder
          .map((product) => {"product_id": product.product.id, "count": product.count})
          .toList();
      final userName = _name;
      final userPhone = '$_countryCode$_phoneNumber';
      final deliveryId = _selectedDeliveryOptionId;
      final deliveryType = _selectedDeliveryOptionType;
      final paymentId = _paymentOptionId;
      final paymentType = _paymentOptionType;

      await _orderApiService.placeOrder(
        products: products,
        userName: userName,
        userPhone: userPhone,
        deliveryId: deliveryId,
        deliveryType: deliveryType,
        paymentId: paymentId,
        paymentType: paymentType,
      );

    } catch (e) {
      print('Failed to place order: $e');
    }
  }

}

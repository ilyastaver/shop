import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theshop/navigation/app_router.dart';
import 'package:theshop/widgets/fill_button.dart';
import 'package:theshop/models/cart.dart';
import 'package:theshop/widgets/cart_item.dart'; // Import the CartItem widget

import '../../api/cart/api_service.dart';
import '../order_page/order_page.dart';

@RoutePage()
class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  CartResponse? _cartModel;
  bool _loading = true;


  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchCartData();

    _scrollController.addListener(_onScroll);

    Timer.periodic(Duration(seconds: 7), (timer) {
      _fetchCartData();
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_loading && _scrollController.position.atEdge && _scrollController.position.pixels == 0) {
      _fetchCartData();
    }
  }

  Future<CartResponse> _fetchCartData() async {
    try {
      CartApiService apiService = CartApiService();
      CartResponse cartResponse = await apiService.getCartData();
      setState(() {
        _cartModel = cartResponse;
        _loading = false;
      });
      return _cartModel!;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch data');
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

  Future<void> _onItemDeleted() async {
    await _fetchCartData();
  }

  Map<String, List<CartProduct>> groupProductsByBrand(List<CartProduct> products) {
    Map<String, List<CartProduct>> groupedProducts = {};
    for (var product in products) {
      String brand = product.product.brand;
      if (!groupedProducts.containsKey(brand)) {
        groupedProducts[brand] = [];
      }
      groupedProducts[brand]!.add(product);
    }
    return groupedProducts;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<CartProduct>> groupedProducts =
    groupProductsByBrand(_cartModel?.products ?? []);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Корзина',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Material(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_loading == true)
                  const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                if (_cartModel != null)
                  if (_cartModel != null)
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: groupedProducts.keys.length,
                        itemBuilder: (context, groupIndex) {
                          String brand = groupedProducts.keys.elementAt(groupIndex);
                          List<CartProduct> products = groupedProducts[brand]!;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Бренд: $brand',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) => const Divider(
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final cartProduct = products[index];
                                    return CartItem(
                                      product: cartProduct.product,
                                      onDelete: _onItemDeleted,
                                      productCount: cartProduct.count,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                if (_cartModel == null)
                  const Text(
                    'В вашей корзине пока ничего нет',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                if (_cartModel != null)
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Итого:  ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),),
                      Text(
                        _cartModel != null ? _formatPrice(_cartModel!.price) : '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),
                const SizedBox(height: 10,),
                if (_cartModel != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Старая цена:  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _formatPrice(_cartModel!.oldPrice),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 10,),
                if (_cartModel != null)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      color: Colors.black,
                      child: OpenContainer(
                        transitionType: ContainerTransitionType.fade,
                        openBuilder: (context, _) => OrderPage(selectedOrder: _cartModel!.products),
                        closedElevation: 0,
                        closedColor: Colors.black,
                        closedShape: const RoundedRectangleBorder(),
                        closedBuilder: (context, VoidCallback openContainer) {
                          return FillButton(
                            onPressed: openContainer,
                            buttonName: 'ОФОРМИТЬ ЗАКАЗ',
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

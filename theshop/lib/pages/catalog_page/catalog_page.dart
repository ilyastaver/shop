import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theshop/widgets/product_item.dart';
import 'package:theshop/models/product.dart';
import 'package:theshop/widgets/search_bar.dart';
import 'package:theshop/api/products/api_service.dart';

import '../product_page/product_page.dart';


@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final ApiService _apiService = ApiService();
  List<Product> yummyProducts = [];
  List<Product> filteredProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      final products = await _apiService.fetchProducts();
      setState(() {
        yummyProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = true;
      });
    }
  }

  void _updateFilteredProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = yummyProducts;
      });
    } else {
      setState(() {
        filteredProducts = yummyProducts
            .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Каталог товаров',
          // style: textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchInput(onSearchChanged: _updateFilteredProducts),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: filteredProducts.isNotEmpty ? filteredProducts.length : yummyProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 164 / 250,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts.isNotEmpty ? filteredProducts[index] : yummyProducts[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: OpenContainer(
                        openElevation: 0,
                        closedElevation: 0,
                        transitionDuration: const Duration(milliseconds: 10),
                        closedBuilder: (context, openContainer) {
                          return InkWell(
                            onTap: () => openContainer(),
                            child: ProductItem(product: product),
                          );
                        },
                        openBuilder: (context, action) {
                          return ProductPage(product: product);
                        },
                        tappable: false,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
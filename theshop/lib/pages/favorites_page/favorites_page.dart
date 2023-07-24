import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:theshop/navigation/app_router.dart';
import 'package:theshop/widgets/fill_button.dart';

import '../../models/product.dart';
import '../../redux/app_state.dart';
import '../../widgets/product_item.dart';
import '../product_page/product_page.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final buttonNameText = 'Перейти к покупкам';

  @override
  Widget build(BuildContext context) {
    void onPressedCallback() {
      context.router.push(CatalogTab());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Избранное'),
      ),
      body: SafeArea(
        child: StoreConnector<AppState, List<Product>>(
          converter: (store) => store.state.favoriteProducts,
          builder: (context, favoriteProducts) {
            if (favoriteProducts.isEmpty) {
              // Display the text when the favorite products list is empty
              return Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                child: const Center(
                  child: Text(
                    'В Вашем избранном пока ничего нет',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              );
            } else {
              // Display the GridView when the favorite products list is not empty
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: favoriteProducts.length,
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 164 / 250,
                      ),
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: OpenContainer(
                            openElevation: 0,
                            closedElevation: 0,
                            transitionDuration:
                            const Duration(milliseconds: 200),
                            closedBuilder: (context, openContainer) {
                              return GestureDetector(
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
                  // Center(
                  //   child: SizedBox(
                  //     width: double.infinity, // Full width
                  //     height: 50,
                  //     child: Container(
                  //       color: Colors.black,
                  //       child: FillButton(
                  //         onPressed: onPressedCallback,
                  //         buttonName: buttonNameText,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

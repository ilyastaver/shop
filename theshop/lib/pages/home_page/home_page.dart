import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:theshop/my_flutter_app_icons.dart';
import 'package:theshop/navigation/app_router.dart';

import '../../redux/app_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      routes: const [
        ShowcaseTab(),
        CatalogTab(),
        ShoppingCartTab(),
        FavoritesTab(),
        ProfileTab(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return StoreConnector<AppState, int>(
          converter: (store) => store.state.favoriteProducts.length,
          builder: (context, favoriteCount) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              unselectedItemColor: const Color(0xFFB8B8B8),
              selectedItemColor: const Color(0xFF1f1f1f),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.vitrina),
                  label: 'Витрина',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.katalog),
                  label: 'Каталог',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.korzina),
                  label: 'Корзина',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(MyFlutterApp.heart),
                      if (favoriteCount > 0)
                        Positioned(
                          top: -4,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              favoriteCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: 'Избранное',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.profile),
                  label: 'Профиль',
                ),
              ],
              selectedLabelStyle: const TextStyle(fontSize: 10.0),
            );
          },
        );
      },
    );
  }
}

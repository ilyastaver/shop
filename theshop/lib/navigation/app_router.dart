import 'package:auto_route/auto_route.dart';
import 'package:theshop/pages/catalog_page/catalog_page.dart';
import 'package:theshop/pages/showcase_page/showcase_page.dart';
import 'package:theshop/pages/favorites_page/favorites_page.dart';
import 'package:theshop/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:theshop/pages/product_page/product_page.dart';
import 'package:theshop/pages/profile_page/profile_page.dart';
import 'package:theshop/pages/home_page/home_page.dart';
import 'package:theshop/pages/order_page/order_page.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(page: CatalogRoute.page),
        AutoRoute(
          initial: true,
          page: HomeRoute.page,
          children: [
            AutoRoute(
              page: ShowcaseTab.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: ShowcaseRoute.page,
                ),
              ],
            ),
            AutoRoute(
              initial: true,
              page: CatalogTab.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: CatalogRoute.page,
                ),
                AutoRoute(
                    page: ProductRoute.page,
                ),
              ],
            ),
            AutoRoute(
              page: ShoppingCartTab.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: ShoppingCartRoute.page,
                ),
                AutoRoute(page: OrderRoute.page)
              ],
            ),
            AutoRoute(
              page: FavoritesTab.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: FavoritesRoute.page,
                ),

              ],
            ),
            AutoRoute(
              page: ProfileTab.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: ProfileRoute.page,
                ),
              ],
            ),
          ],
        )
      ];
}

@RoutePage(name: 'ShowcaseTab')
class ShowcaseTabPage extends AutoRouter {
  const ShowcaseTabPage({super.key});
}

@RoutePage(name: 'CatalogTab')
class CatalogTabPage extends AutoRouter {
  const CatalogTabPage({super.key});
}

@RoutePage(name: 'ShoppingCartTab')
class ShoppingCartTabPage extends AutoRouter {
  const ShoppingCartTabPage({super.key});
}

@RoutePage(name: 'FavoritesTab')
class FavoritesTabPage extends AutoRouter {
  const FavoritesTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}


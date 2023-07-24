import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:theshop/assets/color_schemes.g.dart';
import 'package:theshop/navigation/app_router.dart';
import 'package:theshop/pages/catalog_page/catalog_page.dart';
import 'package:theshop/redux/app_state.dart';

class TheShopApp extends StatelessWidget {
  final Store<AppState> store;

  TheShopApp({required this.store});

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:theshop/models/product.dart';
import 'package:theshop/redux/actions.dart';
import 'package:theshop/redux/app_state.dart';
import 'package:theshop/redux/reducers.dart';
import 'package:theshop/the_shop_app.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(favoriteProducts: [], favoriteCount: 0),
  );
  utf8.decoder;
  runApp(StoreProvider<AppState>(
    store: store,
    child: TheShopApp(store: store,),
  ));
}
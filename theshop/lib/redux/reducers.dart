import 'package:redux/redux.dart';
import 'package:theshop/models/product.dart';
import 'package:theshop/redux/actions.dart';
import 'package:theshop/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is AddToFavoriteAction) {
    List<Product> updatedFavorites = List.from(state.favoriteProducts)..add(action.product);
    return AppState(favoriteProducts: updatedFavorites, favoriteCount: state.favoriteCount + 1);
  } else if (action is RemoveFromFavoriteAction) {
    List<Product> updatedFavorites = List.from(state.favoriteProducts)..removeWhere((p) => p.id == action.productId);
    return AppState(favoriteProducts: updatedFavorites, favoriteCount: state.favoriteCount - 1);
  }
  // Handle other actions if needed
  return state;
}

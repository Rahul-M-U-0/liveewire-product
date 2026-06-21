import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liveewire_products/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cartKey = 'CACHED_CART_ITEMS';

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final jsonString = sharedPreferences.getString(_cartKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
        return decoded.map((item) {
          return CartItemModel.fromJson(item as Map<String, dynamic>);
        }).toList();
      } catch (_) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final List<Map<String, dynamic>> jsonList = items
        .map((item) => item.toJson())
        .toList();
    await sharedPreferences.setString(_cartKey, json.encode(jsonList));
  }
}

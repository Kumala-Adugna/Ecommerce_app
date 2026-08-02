import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferences _preferences;

  static const String tokenKey = 'token';
  static const String userIdKey = 'user_id';
  static const String cartKey = 'cart';

  // ---------------- Token ----------------

  Future<bool> saveToken(String token) async {
    return _preferences.setString(tokenKey, token);
  }

  String? getToken() {
    return _preferences.getString(tokenKey);
  }

  Future<bool> removeToken() async {
    return _preferences.remove(tokenKey);
  }

  // ---------------- User ----------------

  Future<bool> saveUserId(int id) async {
    return _preferences.setInt(userIdKey, id);
  }

  int? getUserId() {
    return _preferences.getInt(userIdKey);
  }

  Future<bool> removeUserId() async {
    return _preferences.remove(userIdKey);
  }

  // ---------------- Cart ----------------

  Future<bool> saveCart(List<Map<String, dynamic>> cart) async {
    return _preferences.setString(
      cartKey,
      jsonEncode(cart),
    );
  }

  List<dynamic> getCart() {
    final json = _preferences.getString(cartKey);

    if (json == null) return [];

    return jsonDecode(json);
  }

  Future<bool> clearCart() async {
    return _preferences.remove(cartKey);
  }

  // ---------------- Session ----------------

  bool isLoggedIn() {
    return getToken() != null;
  }

  Future<void> clearSession() async {
    await removeToken();
    await removeUserId();
    await clearCart();
  }
}
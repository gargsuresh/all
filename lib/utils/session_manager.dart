import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _walletBalanceKey = "credit";
  static const String _userIdKey = "user_id";

  /// Wallet balance
  static Future<String> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletBalanceKey) ?? "0";
  }

  static Future<void> setWalletBalance(String balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletBalanceKey, balance);
  }

  /// User ID
  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_userIdKey);
    if (id != null) {
      return id;
    } else {
      throw Exception("User ID not found in session");
    }
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }
}

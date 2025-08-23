import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<String> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("credit") ?? "0";
  }

  static Future<void> setWalletBalance(String balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("credit", balance);
  }
}

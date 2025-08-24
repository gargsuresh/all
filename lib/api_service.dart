import 'dart:convert';
import 'package:all/repository/models/market_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://atozmatka.com/api/";



  // 🔹 Login API Call
  static Future<Map<String, dynamic>> login(String mobile, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}login.php"),
      body: {"mobile": mobile, "password": password},
    );
    return jsonDecode(response.body);
  }

  // 🔹 Register API Call
  static Future<Map<String, dynamic>> register(String name,String mobile, String email, String password) async {
    final response = await http.post(
      Uri.parse("${baseUrl}register.php"),
      body: {"name": name, "mobile": mobile, "password": password},
    );
    return jsonDecode(response.body);
  }
  // 🔹 Wallet API Call
  static Future<Map<String, dynamic>> getWallet(String userId) async {
    final url = Uri.parse("${baseUrl}get_wallet.php");
    final response = await http.post(url, body: {"user_id": userId});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"success": false, "message": "Server error"};
    }
  }
// 🔹 Market API Call
  static Future<List<Market>> getMarkets() async {
    final response = await http.get(Uri.parse("${baseUrl}get_markets.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        List markets = data['markets'];
        return markets.map((e) => Market.fromJson(e)).toList();
      } else {
        throw Exception("No markets found");
      }
    } else {
      throw Exception("Failed to load markets");
    }
  }



}
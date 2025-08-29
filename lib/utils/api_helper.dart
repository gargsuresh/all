import 'dart:convert';
import 'package:all/utils/session_manager.dart';
import 'package:http/http.dart' as http;

import '../repository/models/market_model.dart';
import '../repository/models/models.dart';

class ApiHelper {
  static const String baseUrl = "https://www.atozmatka.com/api/";


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

  // Get wallet balance
  static Future<String> getWalletBalance() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/get_wallet_balance.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String balance = data['balance'] ?? "0";
        await SessionManager.setWalletBalance(balance);
        return balance;
      } else {
        throw Exception("Failed to load wallet balance");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Withdraw API
  static Future<bool> withdrawFunds(int amount) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/withdraw.php"),
        body: {
          "amount": amount.toString(),
          "user_id": await SessionManager.getUserId(),
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == "success";
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Get Market Name by mid & cmid
  static Future<String> getMarketName(String mid, String cmid) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/get_markets.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final markets = data["markets"] as List;
        final market = markets.firstWhere(
              (m) => m["mid"] == mid && m["cmid"] == cmid,
          orElse: () => null,
        );
        return market != null ? market["name"] ?? "Unknown Market" : "Unknown Market";
      }
      return "Unknown Market";
    } catch (e) {
      return "Unknown Market";
    }
  }

  /// Submit Bids
  static Future<bool> submitBids({
    required String mid,
    required String cmid,
    required List<Map<String, String>> bids,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/submit_bids.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mid": mid,
          "cmid": cmid,
          "bids": bids,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["status"] == "success";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Add Funds
  static Future<void> addFunds(int amount) async {
    try {
      final userId = await SessionManager.getUserId(); // Assuming user id stored
      final response = await http.post(
        Uri.parse("$baseUrl/add_funds.php"),
        body: {
          "amount": amount.toString(),
          "user_id": userId,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] != "success") {
          throw Exception(data['message'] ?? "Failed to add funds");
        }
        // Update wallet locally after adding funds
        await getWalletBalance();
      } else {
        throw Exception("Failed to add funds");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<StatementModel>> getHistory() async {
    final response = await http.get(Uri.parse("https://www.atozmatka.com/api/history.php"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => StatementModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch history");
    }
  }





}

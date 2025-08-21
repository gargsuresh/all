import 'dart:convert';
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
      body: {"name": name, "mobile": mobile, "email": email, "password": password},
    );
    return jsonDecode(response.body);
  }

  // 🔹 Get Users API Call
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse("${baseUrl}get_users.php"));
    var data = jsonDecode(response.body);
    return data["data"];
  }
}

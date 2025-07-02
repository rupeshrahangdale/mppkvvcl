import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mppkvvcl/SRC/constent/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // static const String baseUrl =
  //     ApiEndpoints.baseURL; // Replace with your API base URL
  static final String baseUrl = AppConfig.apiBaseURL;

  // User Login
  Future<http.Response> login(String username, String password) async {
    final url =
        Uri.parse('$baseUrl/api/login'); // Replace with your login endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    return response;
  }

  // Fetch all complaints
  Future<http.Response> fetchComplaints() async {
    final url = Uri.parse(
        '$baseUrl/complaints'); // Replace with your complaints endpoint
    final response = await http.get(url);
    return response;
  }

  // Fetch complaint details by ID
  Future<http.Response> fetchComplaintDetails(String complaintId) async {
    final url = Uri.parse(
        '$baseUrl/complaints/$complaintId'); // Replace with your complaint details endpoint
    final response = await http.get(url);
    return response;
  }

  // Add a new complaint
  Future<http.Response> addComplaint(Map<String, dynamic> complaintData) async {
    final url = Uri.parse(
        '$baseUrl/complaints'); // Replace with your add complaint endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(complaintData),
    );
    return response;
  }

  // Change password

  Future<http.Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String token, // pass token here
  }) async {
    final url = Uri.parse('$baseUrl/api/change-password');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'old_password': oldPassword,
        'password': newPassword,
        'confirm_password': confirmPassword,
      }),
    );
    return response;
  }

  static Future<String?> getCredentialsToken() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('LoginUsername');
    final password = prefs.getString('LoginPassword');

    if (username == null || password == null) {
      print("Username or password not found in SharedPreferences");
      return null;
    }

    final response = await http.post(
      Uri.parse("https://serverx.in/api/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      if (token != null) {
        // Save or update token if needed
        await prefs.setString('token', token);
        print("Token retrieved successfully: $token  \n\n");

        return token;
      }
    }

    print("Failed to retrieve token. Status: ${response.statusCode}");
    return null;
  }

  Future<int> fetchComplaintCountByStatus({
    required int userId,
    required int status,
  }) async {
    final url =
        Uri.parse('https://serverx.in/api/complaint-stats?user_id=$userId');
    final credentialsToken = await ApiService.getCredentialsToken();

    final response = await http.get(
      url,
      headers: {
        'Authorization': credentialsToken.toString(),
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == true && json['data'] is List) {
        for (var item in json['data']) {
          if (item['status'] == status) {
            return item['count'] ?? 0;
          }
        }
      }
    }

    // Default fallback if status not found
    return 0;
  }
}

// lib/services/remote_config_service.dart

class RemoteConfigService {
  static Future<void> loadBaseURL() async {
    final url = Uri.parse(
        "https://nextinlabs.com/AppRemoteConfiguration/remote-configure.php");

    final response = await http.post(
      url,
      body: jsonEncode({
        "app_id": "SCDARMDY_C_1",
        "app_package_name": "com.nxtinlbs.scadaremedycms"
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("Base URL response: ${jsonData.toString()}");
      if (jsonData["status"] == "success") {
        AppConfig.apiBaseURL = jsonData["data"]["app_config_url"];
        print(
            "Base URL loaded successfully: ${AppConfig.apiBaseURL}  \n\n\n\n");
      } else {
        throw Exception("Base URL config not found");
      }
    } else {
      throw Exception("Failed to load base URL");
    }
  }
}

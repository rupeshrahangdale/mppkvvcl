import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://your-api-url.com'; // Replace with your API base URL

  // User Login
  Future<http.Response> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login'); // Replace with your login endpoint
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
}

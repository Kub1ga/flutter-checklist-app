import 'dart:convert';
import 'package:checklist_app/models/checklist.dart';
import 'package:checklist_app/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/register.dart';

class ApiService {
  static const String baseUrl = 'http://94.74.86.174:8080/api';
  late String? authToken;

  bool isTokenAvailable() {
    return authToken != null;
  }

  ApiService({String? initialToken}) : authToken = initialToken ?? '';

  Future<bool> login(LoginModels data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['data']['token'] as String;
      authToken = token;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', token);
      print(response.body);
      print(authToken);
      return true;
    } else {
      print('gagal login');
      print(response.body);
      return false;
    }
  }

  Future<void> addChecklist(String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/checklist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authToken ?? ''}',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        print('Checklist berhasil ditambahkan');
      } else {
        print(response.body);
        print('Gagal menambah checklist. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> register(RegisterModels data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      print('berhasil');
      print(response.body);
      return true;
    } else {
      print('gagal');
      print(response.body);
      return false;
    }
  }

  Future<List<Checklist>> getAllChecklists() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/checklist'),
        headers: <String, String>{
          'Authorization': 'Bearer ${authToken ?? ''}',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> checklistJsonList = jsonDecode(response.body);
        return checklistJsonList
            .map((json) => Checklist.fromJson(json))
            .toList();
      } else {
        print(authToken);
        throw Exception('Failed to load checklists');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    print(authToken);
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

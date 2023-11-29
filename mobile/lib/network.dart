// Singleton Class
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:kelulusan/model/user.dart';

class Network {
  static const BASE_URL = "https://kelulusan.tesyarraz.my.id/api";
  static Network? _instance;

  static Network get instance {
    // Jika instance null, assign kan objectnya
    _instance ??= Network._();

    return _instance!;
  }

  final _client = new Client();
  Network._();

  Future<dynamic> loginAndGetUserdata(String nis, String password) async {
    var response = await _client.post(
      Uri.parse("${BASE_URL}/login"),
      body: {
        'nis' : nis,
        'password' : password
      }
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['user']);
    }
    else if (response.statusCode == 401) {
      return "NIS atau password salah";
    }
    else {
      return "Server Error, Harap Hubungi Admin";
    }
  }
}
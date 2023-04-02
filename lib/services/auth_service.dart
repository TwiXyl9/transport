import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport/models/auth.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/requests/requests_config.dart';
import 'package:transport/requests/requests_paths_names.dart';

import '../models/prefs.dart';
class AuthService {
  // Future<void> setAuthorizationData(http.Response response) async {
  //   final responseData = json.decode(response.body);
  //   final prefs = await SharedPreferences.getInstance();
  //   token = response.headers['access-token'];
  //   uid = response.headers['uid'];
  //   client = response.headers['client'];
  //   userId = responseData['data']['id'];
  //   expiryDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(response.headers['expiry']!) * 1000);
  //   final userData = json.encode(
  //     {
  //       'access-token': token,
  //       'user_id': userId,
  //       'uid': uid,
  //       'client': client,
  //       'expiry': response.headers['expiry']
  //     },
  //   );
  //   prefs.setString('userData', userData);
  // }

  Future<http.Response> _authenticate(String prefix, Map<String, String> body) async {
    final url = '$baseUrl$authPath$prefix';
    late http.Response response;
    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      //setAuthorizationData(response);
    } catch (error) {
      print(error);
    }
    return response;
  }

  Future<http.Response> signup(String name, String phone, String email, String password, String confirmPassword) async {
    return _authenticate('/',
      {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
  }

  Future<http.Response> login(String email, String password) async {
    return _authenticate('/sign_in', {
      'email': email,
      'password': password,
    },);
  }

  void logout() {
    Prefs.clear();
  }
}

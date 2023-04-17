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

  Future<dynamic> _authenticate(String prefix, Map<String, String> body) async {
    final url = '$baseUrl$authPath$prefix';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode != 201 && response.statusCode != 200) {
        return new HttpException(responseData['errors'][0]);
      }

      return Auth.fromMap(responseData, response.headers);
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> signup(String name, String phone, String email, String password, String confirmPassword) async {
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

  Future<dynamic> login(String email, String password) async {
    return _authenticate('/sign_in', {
      'email': email,
      'password': password,
    },);
  }

}

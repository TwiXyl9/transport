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

  Future<Auth> _authenticate(String prefix, Map<String, String> body) async {
    final url = '$baseUrl$authPath$prefix';
    late Auth auth;
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      auth = Auth.fromResponse(response);
    } catch (error) {
      print(error);
    }
    return auth;
  }

  Future<Auth> signup(String name, String phone, String email, String password, String confirmPassword) async {
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

  Future<Auth> login(String email, String password) async {
    return _authenticate('/sign_in', {
      'email': email,
      'password': password,
    },);
  }

}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport/models/prefs.dart';
class Auth {
  late String? token;
  late DateTime? expiryDate;
  late String? uid;
  late String? client;

  Auth(this.token, this.expiryDate, this.uid, this.client);

  Auth.fromResponse(http.Response response) {
    final responseData = json.decode(response.body);
    token = response.headers['access-token'];
    uid = response.headers['uid'];
    client = response.headers['client'];
    expiryDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(response.headers['expiry']!) * 1000);
    final authData = json.encode(
      {
        'access-token': token,
        'uid': uid,
        'client': client,
        'expiry': response.headers['expiry']
      },
    );
    final userData = json.encode(
      {
        'id': responseData['data']['id'],
        'name': responseData['data']['name'],
        'phone': responseData['data']['phone'],
        'email': responseData['data']['email']
      },
    );
    Prefs.setString('authData', authData);
    Prefs.setString('userData', userData);
  }

  Map<String, dynamic> mapFromFields() {
    return {
      'access-token': token, 'uid': uid, 'client': client
    };
  }

  bool get isAuth {
    return token != null;
  }
}
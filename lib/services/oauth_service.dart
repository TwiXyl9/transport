import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:transport/config/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:transport/requests/requests_paths_names.dart';

import '../models/auth.dart';
import '../models/http_exception.dart';
import '../requests/requests_config.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(
    clientId: Secrets.CLIENT_ID,
    scopes: <String>[
      'email',
    ],
  );


  Future<dynamic> Login() async {
    return await _googleSignIn.signIn();
  }

  Future<dynamic> registration(token, phone) async {
    return await authenticationInSystem({
      'provider': "google_oauth2",
      'accessToken': token,
      'phone': phone
    });
  }

  static Future<GoogleSignInAccount?> SignOut() {
    return _googleSignIn.signOut();
  }

  Future<dynamic> authenticationInSystem(Map<String, dynamic> body) async {
    final url = '$baseUrl$googleOmniauthPath';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body)
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode != 201 && response.statusCode != 200) {
        print(responseData);
        if (responseData.containsKey('errors')) return new HttpException(response.statusCode, responseData['errors'][0]);
        return new HttpException(response.statusCode, responseData['error']);
      }
      return Auth.fromMap(responseData, response.headers);
    } catch (error) {
      print(error);
    }
  }
}
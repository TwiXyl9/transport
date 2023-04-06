import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transport/models/car.dart';
import 'package:transport/models/service.dart';
import 'dart:async';
import 'dart:convert';

import '../models/news.dart';
import '../models/user.dart';
import '../requests/requests_config.dart';

class ApiService {

  final String apiUrl = baseUrl+"/api/v1";

  Future<http.Response> createNews(String name, String price, String image) async {
    var body = jsonEncode({
      "news": {"name": name, "price": price, "image": image}
    });

    http.Response response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);
    return response;
  }
  Future<List<News>> newsIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((news) => News.fromMap(news)).toList();
    } else {
      return [];
    }
  }
  Future<List<Car>> carsIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((cars) => Car.fromMap(cars)).toList();
    } else {
      return [];
    }
  }
  Future<List<Service>> servicesIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((services) => Service.fromMap(services)).toList();
    } else {
      return [];
    }
  }
  Future<http.Response> auth(String email, String password) async {
    var body = jsonEncode({
      'email' : email, 'password' : password
    });

    http.Response response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);
    return response;
  }
  Future<dynamic> userShowRequest(String path, authHeaders) async {
    var fullPath = apiUrl + path;
    authHeaders.addAll(headers);
    http.Response response = await http.get(Uri.parse(fullPath), headers: authHeaders as Map<String, String>);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return User.fromMap(data);
    } else {
      return null;
    }
  }
}

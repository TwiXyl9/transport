import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transport/models/car.dart';
import 'package:transport/models/order.dart';
import 'package:transport/models/service.dart';
import 'dart:async';
import 'dart:convert';

import '../models/cargo_type.dart';
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
      return data.map((car) => Car.fromMap(car)).toList();
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
  Future<List<CargoType>> cargoTypesIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((types) => CargoType.fromMap(types)).toList();
    } else {
      return [];
    }
  }
  Future<dynamic> createOrderRequest(path, body) async {
    try {
      var fullPath = apiUrl + path;
      http.Response response = await http.post(
          Uri.parse(fullPath), headers: headers, body: json.encode(body));
      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        return new HttpException(responseData['errors']['full_messages']);
      }
      return new Order.fromMap(responseData);
    } catch(e){
      print(e);
    }
  }
  Future<List<Order>> orderIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((order) => Order.fromMap(order)).toList();
    } else {
      return [];
    }
  }
}

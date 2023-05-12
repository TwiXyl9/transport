import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transport/models/car.dart';
import 'package:transport/models/order.dart';
import 'package:transport/models/service.dart';
import 'package:transport/models/http_exception.dart';
import 'dart:async';
import 'dart:convert';

import '../models/cargo_type.dart';
import '../models/news.dart';
import '../models/tail_type.dart';
import '../models/user.dart';
import '../requests/requests_config.dart';

class ApiService {

  final String apiUrl = baseUrl+"/api/v1";

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
    print('CarsIndex');
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
    try {
      var fullPath = apiUrl + path;
      Map<String, String> fullHeaders = {}..addAll(authHeaders)..addAll(headers);
      http.Response response = await http.get(Uri.parse(fullPath), headers: fullHeaders as Map<String, String>);
      print(response.statusCode);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.headers);
        print('Before - ${authHeaders}');
        if (response.headers['access-token']! != '') authHeaders['access-token'] = response.headers['access-token']!;
        print('After - $authHeaders');
        return new User.fromMap(responseData);
      } else {
        print(responseData);
        return new HttpException(responseData['errors'][0]);
      }
    } catch(e){
      print(e);
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
      return true;
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
  Future<dynamic> usersOrdersIndexRequest(path, authHeaders) async {
    try {
      var fullPath = apiUrl + path;
      Map<String, String> fullHeaders = {}..addAll(authHeaders)..addAll(headers);
      http.Response response = await http.get(Uri.parse(fullPath), headers: fullHeaders as Map<String, String>);
      print(response.statusCode);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.headers['access-token']! != '') authHeaders['access-token'] = response.headers['access-token']!;
        List<dynamic> data = jsonDecode(response.body);
        return data.map((order) => Order.fromMap(order)).toList();
      } else {
        print(responseData);
        return new HttpException(responseData['errors'][0]);
      }
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> createNewsRequest(path, news) async {
    try {
      var fullPath = apiUrl + path;

      var request = http.MultipartRequest('POST', Uri.parse(fullPath))
        ..fields.addAll(news.mapFromFields())
        ..files.add(news.imageFile);
      print(request.fields);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return new News.fromMap(responseData);
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> updateNewsRequest(path, news) async {
    try {
      var fullPath = apiUrl + path + '/${news.id}';
      var request = http.MultipartRequest('PATCH', Uri.parse(fullPath))
        ..fields.addAll(news.mapFromFields())
        ..files.add(news.imageFile);
      print(request.files);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return true;
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> createCarRequest(path, Car car) async {
    try {
      var fullPath = apiUrl + path;

      var request = http.MultipartRequest('POST', Uri.parse(fullPath))
        ..fields.addAll(car.namedMapFromFields())
        ..fields.addAll(car.capacity.namedMapFromFields())
        ..files.addAll(car.imagesFiles);
      print(request.fields);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return new Car.fromMap(responseData);
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> delete(path, data) async {
    try {
      var fullPath = apiUrl + path +"/${data.id}";

      http.Response response = await http.delete(Uri.parse(fullPath), headers: headers);
      if (response.statusCode != 204) {
        final responseData = json.decode(response.body);
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      } else {
        return true;
      }
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> updateCarRequest(path, Car car) async {
    try {
      var fullPath = apiUrl + path + '/${car.id}';
      var request = http.MultipartRequest('PATCH', Uri.parse(fullPath))
        ..fields.addAll(car.namedMapFromFields())
        ..fields.addAll(car.capacity.namedMapFromFields())
        ..files.addAll(car.imagesFiles);
      print(request.files);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return true;
    } catch(e){
      print(e);
    }
  }
  Future<List<TailType>> tailTypesIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((types) => TailType.fromMap(types)).toList();
    } else {
      return [];
    }
  }
  Future<dynamic> updateUserRequest(path, User user, authHeaders) async {
    try {
      var fullPath = apiUrl + path + '/${user.id}';
      Map<String, String> fullHeaders = {}..addAll(authHeaders)..addAll(headers);
      http.Response response = await http.patch(Uri.parse(fullPath), headers: fullHeaders, body: jsonEncode(user.mapForUpdate()));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.headers['access-token']! != '') authHeaders['access-token'] = response.headers['access-token']!;
        return new User.fromMap(responseData);
      } else {
        return new HttpException(responseData['errors']['full_messages']);
      }
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> createCargoTypeRequest(path, type) async {
    try {
      var fullPath = apiUrl + path;
      http.Response response = await http.post(Uri.parse(fullPath), headers: headers, body: jsonEncode(type.mapFromFields()));
      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return new CargoType.fromMap(responseData);
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> updateCargoTypeRequest(path, type) async {
    try {
      var fullPath = apiUrl + path + '/${type.id}';
      //Map<String, String> fullHeaders = {}..addAll(authHeaders)..addAll(headers);
      http.Response response = await http.patch(Uri.parse(fullPath), headers: headers, body: jsonEncode(type.mapFromFields()));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
       // if (response.headers['access-token']! != '') authHeaders['access-token'] = response.headers['access-token']!;
        return new CargoType.fromMap(responseData);
      } else {
        return new HttpException(responseData['errors']['full_messages']);
      }
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> updateAdditionalServiceRequest(path, service) async {
    try {
      var fullPath = apiUrl + path + '/${service.id}';
      //Map<String, String> fullHeaders = {}..addAll(authHeaders)..addAll(headers);
      http.Response response = await http.patch(Uri.parse(fullPath), headers: headers, body: jsonEncode(service.mapFromFields()));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // if (response.headers['access-token']! != '') authHeaders['access-token'] = response.headers['access-token']!;
        return new CargoType.fromMap(responseData);
      } else {
        return new HttpException(responseData['errors']['full_messages']);
      }
    } catch(e){
      print(e);
    }
  }
  Future<List<Service>> additionalServiceIndexRequest(path) async {
    var fullPath = apiUrl + path;
    http.Response response = await http.get(Uri.parse(fullPath), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((type) => Service.fromMap(type)).toList();
    } else {
      return [];
    }
  }
  Future<dynamic> create(path, data) async {
    try {
      var fullPath = apiUrl + path;

      var request = http.MultipartRequest('POST', Uri.parse(fullPath))
        ..fields.addAll(data.mapFromFields())
        ..files.add(data.imageFile);
      print(request.fields);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return new News.fromMap(responseData);
    } catch(e){
      print(e);
    }
  }
  Future<dynamic> update(path, data) async {
    try {
      var fullPath = apiUrl + path + '/${data.id}';
      var request = http.MultipartRequest('PATCH', Uri.parse(fullPath))
        ..fields.addAll(data.mapFromFields())
        ..files.add(data.imageFile);
      print(request.files);
      var response = await http.Response.fromStream(await request.send());
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        print(responseData);
        return new HttpException(responseData['errors']['full_messages']);
      }
      return true;
    } catch(e){
      print(e);
    }
  }
}

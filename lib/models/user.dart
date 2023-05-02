import 'dart:convert';

import 'package:transport/models/prefs.dart';

class User {
  late int? id;
  late String name;
  late String phone;
  late String email;
  late String role;
  User(this.id, this.name, this.phone, this.role);
  User.createGuest(){
    id = 0;
    name = '';
    phone = '';
    role = 'guest';
  }
  User.fromData(this.id, this.name, this.phone, this.email);
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    role = map['role'];
    final userData = json.encode(
      {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'role': role
      },
    );
    Prefs.setString("userData", userData);
  }

  bool isAdmin(){
    return this.role == "admin";
  }

  Map<String, dynamic> mapFromFields() {
    return {'user':{'name': name, 'phone': phone, 'email': email}};
  }
}
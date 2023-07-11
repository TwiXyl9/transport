import 'dart:convert';

import 'package:transport/models/prefs.dart';

class User {
  late int? id;
  late String name;
  late String phone;
  late String email;
  late String role;

  User(this.id);
  User.createGuest(){
    id = 0;
    name = '';
    phone = '';
    role = 'guest';
  }
  User.fromData(this.id, this.name, this.phone, this.email);
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'].runtimeType != int? int.parse(map['id']) : map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    role = map['role'];
  }

  bool isAdmin(){
    return this.role == "admin";
  }

  Map<String, dynamic> mapFromFields() {
    return {'user': {'id': id.toString(), 'name': name, 'phone': phone, 'email': email, 'role': role}};
  }

  Map<String, dynamic> mapForUpdate() {
    return {'user': {'name': name, 'phone': phone}};
  }

}
import 'dart:convert';

import 'package:transport/models/prefs.dart';

class User {
  late int id;
  late String name;
  late String phone;
  late String email;

  User(this.id, this.name, this.phone, this.email);
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    final userData = json.encode(
      {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email
      },
    );
    Prefs.setString("userData", userData);
  }

  Map<String, dynamic> mapFromFields() {
    return {'user':{'name': name, 'phone': phone, 'email': email}};
  }
}
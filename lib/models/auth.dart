import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transport/models/user.dart';
class Auth {
  late String? token;
  late DateTime? expiryDate;
  late String? uid;
  late String? client;
  late User user;

  Auth(this.token, this.expiryDate, this.uid, this.client, this.user);

  Auth.fromMap(data, headers) {
      user = User.fromMap(data['data']);
      token = headers['access-token'];
      uid = headers['uid'];
      client = headers['client'];
      expiryDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(headers['expiry']!) * 1000);
  }

  Auth.fromJson(json){
    token = json['access-token'];
    uid = json['uid'];
    client = json['client'];
  }

  Map<String, dynamic> mapFromFields() {
    Map<String, String> data = {'access-token': token!, 'uid': uid!, 'client': client!};
    return data;
  }

  bool get isAuth {
    return token != null;
  }
}
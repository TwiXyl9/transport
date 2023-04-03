import 'dart:convert';
import 'package:http/http.dart' as http;
class Auth {
  late String? token;
  late DateTime? expiryDate;
  late String? uid;
  late String? client;
  late int? userId;

  Auth(this.token, this.expiryDate, this.uid, this.client);

  Auth.fromResponse(http.Response response) {
    final responseData = json.decode(response.body);
    userId = responseData['id'];
    token = response.headers['access-token'];
    uid = response.headers['uid'];
    client = response.headers['client'];
    expiryDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(response.headers['expiry']!) * 1000);
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
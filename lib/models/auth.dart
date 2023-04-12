import 'dart:convert';
import 'package:http/http.dart' as http;
class Auth {
  late String? token;
  late DateTime? expiryDate;
  late String? uid;
  late String? client;
  late String? authorization;
  late int? userId;
  late String? errorMsg;

  Auth(this.token, this.expiryDate, this.uid, this.client, this.userId);

  Auth.fromResponse(http.Response response) {
    final responseData = json.decode(response.body);
    if(responseData['errors'] != null){
      //if (responseData['errors']['full_messages'] != null) {
      //  errorMsg = responseData['errors']['full_messages'][0];
      //} else {
        errorMsg = responseData['errors'][0];
      //}
    } else {
      errorMsg = null;
      userId = responseData['data']['id'];
      token = response.headers['access-token'];
      uid = response.headers['uid'];
      client = response.headers['client'];
      expiryDate = new DateTime.fromMillisecondsSinceEpoch(int.parse(response.headers['expiry']!) * 1000);
    }
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
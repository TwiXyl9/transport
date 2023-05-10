import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

abstract class _Keys {
  static const authData = 'authData';
  static const user = 'user';
}
class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getAuthData() => _secureStorage.read(key: _Keys.authData);

  Future<void> setAuthData(String data) {
    return _secureStorage.write(key: _Keys.authData, value: data);
  }

  Future<void> deleteAuthData() {
    return _secureStorage.delete(key: _Keys.authData);
  }

  Future<User?> getUser() async {
    final userData = await _secureStorage.read(key: _Keys.user);
    if (userData != null) return User.fromMap(jsonDecode(userData)['user']);
    return null;
  }

  Future<void> setUser(User user) {
    return _secureStorage.write(
      key: _Keys.user,
      value: jsonEncode(user.mapFromFields()),
    );
  }

  Future<void> deleteUser() {
    return _secureStorage.delete(key: _Keys.user);
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const authData = 'authData';
  static const accountId = 'account_id';
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

  Future<int?> getAccountId() async {
    final id = await _secureStorage.read(key: _Keys.accountId);
    return id != null ? int.tryParse(id) : null;
  }

  Future<void> setAccountId(int value) {
    return _secureStorage.write(
      key: _Keys.accountId,
      value: value.toString(),
    );
  }

  Future<void> deleteAccountId() {
    return _secureStorage.delete(key: _Keys.accountId);
  }
}
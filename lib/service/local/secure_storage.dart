import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._(this._storage);
  static final instance = SecureStorage._(const FlutterSecureStorage());

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'TOKEN';
  static const _emailKey = 'EMAIL';
  static const _userId = 'EMAIL';

  Future<void> persistEmailAndToken(
      String? email, String? token, int? id) async {
    if (email != null) await _storage.write(key: _emailKey, value: email);
    if (token != null) await _storage.write(key: _tokenKey, value: token);
    if (id != null) await _storage.write(key: _userId, value: id.toString());
  }

  Future<bool> hasToken() async {
    String? value = await _storage.read(key: _tokenKey);
    if (value == null || value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> hasEmail() async {
    var value = await _storage.read(key: _emailKey);
    if (value == null || value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteUserData() async {
    return _storage.deleteAll();
  }

  Future<void> deleteEmail() async {
    return _storage.delete(key: _emailKey);
  }

  Future<String?> getEmail() async {
    return _storage.read(key: _emailKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: _userId);
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}

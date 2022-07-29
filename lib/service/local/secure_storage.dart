import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._(this._storage);
  static final instance = SecureStorage._(const FlutterSecureStorage());

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'TOKEN';
  static const _emailKey = 'EMAIL';

  Future<void> persistEmailAndToken(String email, String token) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _tokenKey, value: token);
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

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
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

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}

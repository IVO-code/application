import 'package:application/data/token/token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyId = 'id';

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);

  static Future<bool> hasToken() async =>
      (await _storage.read(key: _keyToken)) != null;

  static Future setToken(Token token) async =>
      await _storage.write(key: _keyToken, value: token.token);

  static Future invalidate() async => await _storage.deleteAll();

  static Future<String?> getId() async => await _storage.read(key: _keyId);

  static Future setId(String id) async =>
      await _storage.write(key: _keyId, value: id);
}

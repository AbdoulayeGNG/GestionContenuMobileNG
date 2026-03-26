import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _keyToken = 'auth_token';
  static const _keyRole = 'user_role';
  static const _keyUserId = 'user_id';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _cachedToken;
  String? _cachedRole;
  String? _cachedUserId;

  Future<void> saveSession({required String token, required String role, required String userId}) async {
    _cachedToken = token;
    _cachedRole = role;
    _cachedUserId = userId;
    await _storage.write(key: _keyToken, value: token);
    await _storage.write(key: _keyRole, value: role);
    await _storage.write(key: _keyUserId, value: userId);
  }

  Future<void> clear() async {
    _cachedToken = null;
    _cachedRole = null;
    _cachedUserId = null;
    await _storage.deleteAll();
  }

  Future<String?> get token async => _cachedToken ??= await _storage.read(key: _keyToken);
  Future<String?> get role async => _cachedRole ??= await _storage.read(key: _keyRole);
  Future<String?> get userId async => _cachedUserId ??= await _storage.read(key: _keyUserId);
}

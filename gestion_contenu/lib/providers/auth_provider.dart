import 'package:flutter/material.dart';
import 'package:gestioncontenu/models/user.dart';
import 'package:gestioncontenu/services/auth_service.dart';
import 'package:gestioncontenu/services/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final TokenStorage _storage;

  AppUser? _user;
  String? _token;
  bool _loading = false;

  AuthProvider(this._authService, this._storage);

  AppUser? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  bool get isLoading => _loading;

  Future<void> loadSession() async {
    _token = await _storage.token;
    final role = await _storage.role;
    final userId = await _storage.userId;
    if (_token != null && role != null && userId != null) {
      _user = AppUser(id: userId, firstName: '', lastName: '', email: '', role: role);
    }
    notifyListeners();
  }

  Future<String?> login({required String email, required String password}) async {
    try {
      _loading = true;
      notifyListeners();
      final (token, user) = await _authService.login(email: email, password: password);
      _token = token;
      _user = user;
      await _storage.saveSession(token: token, role: user.role, userId: user.id);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<String?> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      _loading = true;
      notifyListeners();
      await _authService.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _storage.clear();
    _user = null;
    _token = null;
    notifyListeners();
  }
}

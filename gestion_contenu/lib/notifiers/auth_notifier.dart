import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestioncontenu/services/auth_service.dart';
import 'package:gestioncontenu/services/token_storage.dart';
import 'package:gestioncontenu/models/user.dart';

// État de l'authentification
class AuthState {
  final AppUser? user;
  final String? token;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.token,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AppUser? user,
    String? token,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier qui gère l'état d'authentification
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final TokenStorage _storage;

  AuthNotifier(this._authService, this._storage) : super(AuthState());

  Future<void> loadSession() async {
    final token = await _storage.token;
    if (token != null && token.isNotEmpty) {
      final role = await _storage.role;
      final userId = await _storage.userId;
      if (role != null && userId != null) {
        state = state.copyWith(
          token: token,
          user: AppUser(id: userId, firstName: '', lastName: '', email: '', role: role),
        );
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    try {
      final (token, user) = await _authService.login(email: email, password: password);
      state = state.copyWith(token: token, user: user, isLoading: false);
      await _storage.saveSession(token: token, role: user.role, userId: user.id);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> logout() async {
    await _storage.clear();
    state = AuthState();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestioncontenu/services/api_client.dart';
import 'package:gestioncontenu/services/auth_service.dart';
import 'package:gestioncontenu/services/token_storage.dart';

// Provider pour TokenStorage
final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

// Provider pour ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);  // Utilisation du provider TokenStorage
  return ApiClient(tokenStorage);
});

// Provider pour AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);  // Utilisation du provider ApiClient
  return AuthService(apiClient);
});

import 'package:dio/dio.dart';
import 'package:gestioncontenu/models/user.dart';
import 'package:gestioncontenu/services/api_client.dart';

class AuthService {
  final ApiClient _client;
  AuthService(this._client);

  Future<(String token, AppUser user)> login({required String email, required String password}) async {
    print(email+','+password);
    print(_client.dio.options.baseUrl);
    final Response res = await _client.dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    print(res);
    final data = res.data as Map<String, dynamic>;
    final token = data['token']?.toString() ?? '';
    final user = AppUser.fromJson(data['user'] as Map<String, dynamic>);
    return (token, user);
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await _client.dio.post('/api/auth/sign-up', data: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });
  }
}


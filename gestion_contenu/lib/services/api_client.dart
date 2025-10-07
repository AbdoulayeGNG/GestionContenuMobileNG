import 'package:dio/dio.dart';
import 'package:gestioncontenu/services/token_storage.dart';

class ApiClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  // Replace with your backend base URL
  static const String baseUrl = 'https://reqres.in/api'; // Example public API for testing

  ApiClient(this._tokenStorage)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
          headers: {'Content-Type': 'application/json', 'x-api-key': 'reqres-free-v1'},
        )) {
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     final token = await _tokenStorage.token;
    //     if (token != null && token.isNotEmpty) {
    //       options.headers['Authorization'] = 'Bearer $token';
    //     }
    //     handler.next(options);
    //   },
    // ));
    
    _dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) async {
    // Ne pas ajouter le token pour login ou register
    final isPublicEndpoint = options.path.contains('/login') || options.path.contains('/sign-up');

    if (!isPublicEndpoint) {
      final token = await _tokenStorage.token;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  },
));



  }

  Dio get dio => _dio;
}

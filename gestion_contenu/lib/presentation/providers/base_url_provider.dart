import 'package:dio/dio.dart';
import 'package:gestioncontenu/core/constants.dart';
import 'package:provider/provider.dart';

final dioProvider = Provider(create: (context) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  return dio;
});

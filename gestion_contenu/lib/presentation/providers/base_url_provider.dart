import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestioncontenu/core/constants.dart';
import 'package:gestioncontenu/data/datasources/content_remote_data_source.dart';

// final dioProvider = Provider(create: (context) {
//   final dio = Dio(BaseOptions(baseUrl: baseUrl));
//   return dio;
// });

final dioProvider = Provider((ref){
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  return dio;
});


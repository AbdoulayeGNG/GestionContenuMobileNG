import 'package:dio/dio.dart';
import 'package:gestioncontenu/data/models/content/content_model.dart';

class ContentRemoteDataSource {
  
  final Dio _dio;

  ContentRemoteDataSource(this._dio);

  Future<List<ContentModel>> getContents() async {
    try {
      final response = await this._dio.get('/contents');
      final data = response.data as List;
      return data.map((json) => ContentModel.fromJson(json)).toList();
    } catch (e) {
      throw "Error lors du chargment des contenus";
    }
  }
}

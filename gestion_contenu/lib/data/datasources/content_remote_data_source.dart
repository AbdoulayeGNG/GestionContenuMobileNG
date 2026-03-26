import 'package:dio/dio.dart';
import 'package:gestioncontenu/data/models/content/content_model.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<ContentModel> getContent(int id) async {
    try {
      final response = await _dio.get('/content/$id');
      final data = response.data;
      return ContentModel.fromJson(data);
    } catch (e) {
      throw "Error lors du chargment des contenus";
    }
  }

  Future<FormData> _handleMakeData(Map<String, dynamic> data) async {
    final XFile? imageFile = data['image'];
    data.remove('image');

    final formData = FormData.fromMap(data);

    if (imageFile != null) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.name,
          ),
        ),
      );
    }
    return formData;
  }

  Future<ContentModel> createContent(Map<String, dynamic> data) async {
    try {
      // 4. Envoyer la requête
      final response =
          await _dio.post('/content', data: await _handleMakeData(data));

      // 5. Convertir la réponse
      return ContentModel.fromJson(response.data);
    } on DioException catch (e) {
      // Erreur spécifique à Dio
      throw "Erreur API: ${e.response?.data?['message'] ?? e.message}";
    } catch (e) {
      // Autres erreurs
      throw "Erreur lors de la création du contenu: $e";
    }
  }

  Future<ContentModel> editContent(Map<String, dynamic> data, id) async {
    try {
      // 4. Envoyer la requête
      final response =
          await _dio.put('/content-edit/$id', data: await _handleMakeData(data));

      // 5. Convertir la réponse
      return ContentModel.fromJson(response.data);
    } on DioException catch (e) {
      // Erreur spécifique à Dio
      throw "Erreur API: ${e.response?.data?['message'] ?? e.message}";
    } catch (e) {
      // Autres erreurs
      throw "Erreur lors de la création du contenu: $e";
    }
  }

  Future<void> deleteContent(int id) async {
    try {
      await _dio.delete('content-delete/$id');
    } on DioException catch (e) {
      // Erreur spécifique à Dio
      throw "Erreur API: ${e.response?.data?['message'] ?? e.message}";
    } catch (e) {
      // Autres erreurs
      throw "Erreur lors de la suppression du contenu: $e";
    }
  }
}

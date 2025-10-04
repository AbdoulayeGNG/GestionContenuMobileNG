import 'package:gestioncontenu/domains/entities/content.dart';

abstract class ContentRepository {
  Future<List<Content>> getContents();
}

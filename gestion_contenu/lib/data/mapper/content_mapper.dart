import 'package:gestioncontenu/data/models/content/content_model.dart';
import 'package:gestioncontenu/domains/entities/content.dart';

class ContentMapper {
  
  static Content toEntity(ContentModel model) {
    return Content(
        id: model.id,
        title: model.title,
        description: model.description,
        image: model.image,
        authorId: model.authorId,
        tags: model.tags,
        category: model.category);
  }
}
import '../../domain/entity/post_entity.dart';
import '../model/post_model.dart';

class PostMapping {
  static PostModel toModel(PostEntity entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
    );
  }

  static PostEntity toEntity(PostModel model) {
    return PostEntity(
      id: model.id,
      title: model.title,
      body: model.body,
    );
  }
}

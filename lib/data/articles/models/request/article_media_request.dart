import 'package:health_management/domain/articles/entities/article_media_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/app/app.dart';

part 'article_media_request.g.dart';

@JsonSerializable()
class ArticleMediaRequest {
  final int? id;
  final int? articleId;
  final MediaType? type;
  final String? url;
  final String? description;
  final int? orderIndex;

  const ArticleMediaRequest({
    this.id,
    this.articleId,
    this.type,
    this.url,
    this.description,
    this.orderIndex,
  });

  factory ArticleMediaRequest.fromJson(Map<String, dynamic> json) =>
      _$ArticleMediaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleMediaRequestToJson(this);

  factory ArticleMediaRequest.fromEntity(ArticleMediaEntity entity) {
    return ArticleMediaRequest(
      id: entity.id,
      articleId: entity.articleId,
      type: entity.type,
      url: entity.url,
      description: entity.description,
      orderIndex: entity.orderIndex,
    );
  }
}

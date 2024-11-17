import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:health_management/app/app.dart';
import 'article_media_request.dart';

part 'article_request.g.dart';

@JsonSerializable()
class ArticleRequest {
  final String? title;
  final String? content;
  final ArticleCategory? category;
  final List<ArticleMediaRequest>? media;

  const ArticleRequest({
    this.title,
    this.content,
    this.category,
    this.media,
  });

  factory ArticleRequest.fromJson(Map<String, dynamic> json) =>
      _$ArticleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleRequestToJson(this);

  factory ArticleRequest.fromEntity(ArticleEntity entity) {
    return ArticleRequest(
      title: entity.title,
      content: entity.content,
      category: entity.category,
      media:
          entity.media?.map((m) => ArticleMediaRequest.fromEntity(m)).toList(),
    );
  }
}

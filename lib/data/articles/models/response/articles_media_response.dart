import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_media_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articles_media_response.g.dart';

@JsonSerializable()
class ArticlesMediaResponse {
  final int? id;
  final int? articleId;
  final MediaType? type;
  final String? url;
  final String? description;
  final int? orderIndex;

  const ArticlesMediaResponse({
    this.id,
    this.articleId,
    this.type,
    this.url,
    this.description,
    this.orderIndex,
  });

  // Chuyển đổi từ JSON sang đối tượng ArticlesMediaResponse
  factory ArticlesMediaResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesMediaResponseFromJson(json);

  // Chuyển đổi từ đối tượng ArticlesMediaResponse sang JSON
  Map<String, dynamic> toJson() => _$ArticlesMediaResponseToJson(this);

  // Chuyển đổi từ ArticlesMediaResponse sang ArticleMediaEntity
  ArticleMediaEntity toEntity() => ArticleMediaEntity(
        id: id,
        articleId: articleId,
        type: type,
        url: url,
        description: description,
        orderIndex: orderIndex,
      );
}

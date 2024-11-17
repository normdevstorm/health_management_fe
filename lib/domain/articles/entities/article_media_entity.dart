import 'package:health_management/app/app.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'article_media_entity.g.dart';

// @JsonSerializable()
class ArticleMediaEntity {
  final int? id;
  final int? articleId;
  final MediaType? type;
  final String? url;
  final String? description;
  final int? orderIndex;

  const ArticleMediaEntity({
    this.id,
    this.articleId,
    this.type,
    this.url,
    this.description,
    this.orderIndex,
  });

  // Thêm các hàm fromJson và toJson
  // factory ArticleMediaEntity.fromJson(Map<String, dynamic> json) =>
  //     _$ArticleMediaEntityFromJson(json);
  // Map<String, dynamic> toJson() => _$ArticleMediaEntityToJson(this);

  ArticleMediaEntity copyWith({
    int? id,
    int? articleId,
    MediaType? type,
    String? url,
    String? description,
    int? orderIndex,
  }) {
    return ArticleMediaEntity(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      type: type ?? this.type,
      url: url ?? this.url,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}

import 'package:health_management/app/app.dart';
import 'package:json_annotation/json_annotation.dart';
// part 'article_vote_entity.g.dart';

// @JsonSerializable()
class ArticleVoteEntity {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? userName;
  final VoteType? type;

  const ArticleVoteEntity({
    this.id,
    this.articleId,
    this.userId,
    this.userName,
    this.type,
  });

  // Thêm các hàm fromJson và toJson
  // factory ArticleVoteEntity.fromJson(Map<String, dynamic> json) =>
  //     _$ArticleVoteEntityFromJson(json);
  // Map<String, dynamic> toJson() => _$ArticleVoteEntityToJson(this);

  ArticleVoteEntity copyWith({
    int? id,
    int? articleId,
    int? userId,
    String? userName,
    VoteType? type,
  }) {
    return ArticleVoteEntity(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      type: type ?? this.type,
    );
  }
}

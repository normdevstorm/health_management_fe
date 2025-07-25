import 'package:health_management/app/app.dart';
// part 'article_vote_entity.g.dart';

// @JsonSerializable()
class ArticleVoteEntity {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? username;
  final VoteType? type;

  const ArticleVoteEntity({
    this.id,
    this.articleId,
    this.userId,
    this.username,
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
      username: userName ?? username,
      type: type ?? this.type,
    );
  }
}

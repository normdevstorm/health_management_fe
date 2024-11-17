import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_vote_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articles_vote_response.g.dart';

@JsonSerializable()
class ArticlesVoteResponse {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? userName;
  final VoteType? type;

  const ArticlesVoteResponse({
    this.id,
    this.articleId,
    this.userId,
    this.userName,
    this.type,
  });

  // Chuyển đổi từ JSON sang đối tượng ArticlesVoteResponse
  factory ArticlesVoteResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesVoteResponseFromJson(json);

  // Chuyển đổi từ đối tượng ArticlesVoteResponse sang JSON
  Map<String, dynamic> toJson() => _$ArticlesVoteResponseToJson(this);

  // Chuyển đổi từ ArticlesVoteResponse sang ArticleVoteEntity
  ArticleVoteEntity toEntity() => ArticleVoteEntity(
      id: id,
      articleId: articleId,
      userId: userId,
      userName: userName,
      type: type);
}

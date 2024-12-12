import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_comment_request.g.dart';

@JsonSerializable()
class ArticleCommentRequest {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? username;
  final String? userAvatar;
  final int? parentId;
  final String? content;
  final int? upvoteCount;
  final int? downvoteCount;
  final List<ArticleCommentRequest>? replies;

  const ArticleCommentRequest({
    this.id,
    this.articleId,
    this.userId,
    this.username,
    this.userAvatar,
    this.parentId,
    this.content,
    this.upvoteCount,
    this.downvoteCount,
    this.replies,
  });

  /// Factory constructor for creating a new instance from a JSON map.
  factory ArticleCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$ArticleCommentRequestFromJson(json);

  /// Method to convert the instance into a JSON map.
  Map<String, dynamic> toJson() => _$ArticleCommentRequestToJson(this);

  factory ArticleCommentRequest.fromEntity(
      ArticleCommentEntity articleCommentEntity) {
    return ArticleCommentRequest(
        id: articleCommentEntity.id,
        articleId: articleCommentEntity.articleId,
        userId: articleCommentEntity.userId,
        username: articleCommentEntity.username,
        userAvatar: articleCommentEntity.userAvatar,
        parentId: articleCommentEntity.parentId,
        content: articleCommentEntity.content,
        upvoteCount: articleCommentEntity.upvoteCount,
        downvoteCount: articleCommentEntity.downvoteCount,
        replies: articleCommentEntity.replies
            ?.map((m) => ArticleCommentRequest.fromEntity(m))
            .toList());
  }
}

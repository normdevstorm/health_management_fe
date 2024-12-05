import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'articles_comment_response.g.dart';

@JsonSerializable()
class ArticlesCommentResponse {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? userName;
  final String? userAvatar;
  final int? parentId;
  final String? content;
  final int? upvoteCount;
  final int? downvoteCount;
  final List<ArticlesCommentResponse>? replies;

  const ArticlesCommentResponse({
    this.id,
    this.articleId,
    this.userId,
    this.userName,
    this.userAvatar,
    this.parentId,
    this.content,
    this.upvoteCount,
    this.downvoteCount,
    this.replies,
  });

  ArticleCommentEntity toEntity() => ArticleCommentEntity(
        id: id,
        articleId: articleId,
        userId: userId,
        userName: userName,
        userAvatar: userAvatar,
        parentId: parentId,
        content: content,
        upvoteCount: upvoteCount,
        downvoteCount: downvoteCount,
        replies: replies?.map((reply) => reply.toEntity()).toList(),
      );

  factory ArticlesCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesCommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesCommentResponseToJson(this);
}

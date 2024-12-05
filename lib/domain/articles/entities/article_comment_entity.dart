// import 'package:json_annotation/json_annotation.dart';
// part 'article_comment_entity.g.dart';

// @JsonSerializable()
class ArticleCommentEntity {
  final int? id;
  final int? articleId;
  final int? userId;
  final String? userName;
  final String? userAvatar;
  final int? parentId;
  final String? content;
  final int? upvoteCount;
  final int? downvoteCount;
  final List<ArticleCommentEntity>? replies;

  const ArticleCommentEntity({
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

  // Các hàm fromJson và toJson
  // factory ArticleCommentEntity.fromJson(Map<String, dynamic> json) =>
  //     _$ArticleCommentEntityFromJson(json);
  // Map<String, dynamic> toJson() => _$ArticleCommentEntityToJson(this);

  ArticleCommentEntity copyWith({
    int? id,
    int? articleId,
    int? userId,
    String? userName,
    int? parentId,
    String? userAvatar,
    String? content,
    int? upvoteCount,
    int? downvoteCount,
    List<ArticleCommentEntity>? replies,
  }) {
    return ArticleCommentEntity(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      parentId: parentId ?? this.parentId,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      downvoteCount: downvoteCount ?? this.downvoteCount,
      replies: replies ?? this.replies,
    );
  }
}

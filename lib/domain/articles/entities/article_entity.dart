import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_media_entity.dart';
import 'package:health_management/domain/articles/entities/article_vote_entity.dart';

class ArticleEntity {
  final int? id;
  final String? title;
  final String? content;
  final int? userId;
  final String? userName;
  final String? userAvatar;
  final int? upVoteCount;
  final int? downVoteCount;
  final int? commentCount;
  final int? viewCount;
  final ArticleCategory? category;
  final ArticleStatus? status;
  final List<ArticleVoteEntity>? votes;
  final List<ArticleCommentEntity>? comments;
  final List<ArticleMediaEntity>? media;

  const ArticleEntity({
    this.id,
    this.title,
    this.content,
    this.userId,
    this.userName,
    this.userAvatar,
    this.upVoteCount,
    this.downVoteCount,
    this.commentCount,
    this.viewCount,
    this.category,
    this.status,
    this.votes,
    this.comments,
    this.media,
  });

  ArticleEntity copyWith({
    int? id,
    String? title,
    String? content,
    int? userId,
    String? userName,
    String? userAvatar,
    int? upVoteCount,
    int? downVoteCount,
    int? commentCount,
    int? viewCount,
    ArticleCategory? category,
    ArticleStatus? status,
    List<ArticleVoteEntity>? votes,
    List<ArticleCommentEntity>? comments,
    List<ArticleMediaEntity>? media,
  }) {
    return ArticleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      upVoteCount: upVoteCount ?? this.upVoteCount,
      downVoteCount: downVoteCount ?? this.downVoteCount,
      commentCount: commentCount ?? this.commentCount,
      viewCount: viewCount ?? this.viewCount,
      category: category ?? this.category,
      status: status ?? this.status,
      votes: votes ?? this.votes,
      comments: comments ?? this.comments,
      media: media ?? this.media,
    );
  }
}

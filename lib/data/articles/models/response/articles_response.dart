import 'package:health_management/app/app.dart';
import 'package:health_management/data/articles/models/response/articles_comment_response.dart';
import 'package:health_management/data/articles/models/response/articles_media_response.dart';
import 'package:health_management/data/articles/models/response/articles_vote_response.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'articles_response.g.dart';

@JsonSerializable()
class ArticlesResponse {
  final int? id;
  final String? title;
  final String? content;
  final int? userId;
  final String? username;
  final String? userAvatar;
  final int? upVoteCount;
  final int? downVoteCount;
  final int? commentCount;
  final int? viewCount;
  final ArticleCategory? category;
  final ArticleStatus? status;
  final List<ArticlesVoteResponse>? votes;
  final List<ArticlesCommentResponse>? comments;
  final List<ArticlesMediaResponse>? media;

  const ArticlesResponse(
      {this.id,
      this.title,
      this.content,
      this.userId,
      this.username,
      this.userAvatar,
      this.upVoteCount,
      this.downVoteCount,
      this.commentCount,
      this.viewCount,
      this.category,
      this.status,
      this.votes,
      this.comments,
      this.media});

  // chuyen tu Json sang doi tuong ArticleResponse
  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);
  // chuyen tu doi tuong ArticleResponse sang Json
  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);

  // chuyen doi tu ArticleResponse sang ArticleEntity
  ArticleEntity toEntity() => ArticleEntity(
        id: id,
        title: title,
        content: content,
        userId: userId,
        username: username,
        userAvatar: userAvatar,
        upVoteCount: upVoteCount,
        downVoteCount: downVoteCount,
        commentCount: commentCount,
        viewCount: viewCount,
        category: category,
        status: status,
        votes: votes?.map((e) => e.toEntity()).toList(),
        comments: comments?.map((e) => e.toEntity()).toList(),
        media: media?.map((e) => e.toEntity()).toList(),
      );
}

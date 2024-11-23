import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

final class GetAllArticleEvent extends ArticleEvent {
  const GetAllArticleEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllArticleByUserIdEvent extends ArticleEvent {
  final int userId;

  const GetAllArticleByUserIdEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

final class CreateArticleEvent extends ArticleEvent {
  final ArticleEntity articleEntity;
  final int userId;

  const CreateArticleEvent(this.articleEntity, this.userId);

  @override
  List<Object?> get props => [articleEntity, userId];
}

final class UpdateArticleEvent extends ArticleEvent {
  final ArticleEntity articleEntity;
  final int userId;

  const UpdateArticleEvent(this.articleEntity, this.userId);
  @override
  List<Object?> get props => [articleEntity, userId];
}

final class DeleteArticleEvent extends ArticleEvent {
  final int articleId;
  final int userId;
  const DeleteArticleEvent(this.articleId, this.userId);

  @override
  List<Object?> get props => [articleId, userId];
}

final class VoteArticleEvent extends ArticleEvent {
  final int articleId;
  final int userId;
  final VoteType voteType;
  const VoteArticleEvent(this.articleId, this.userId, this.voteType);

  @override
  List<Object?> get props => [articleId, userId];
}

final class CommentArticleEvent extends ArticleEvent {
  final int articleId;
  final int userId;
  final ArticleCommentEntity articleCommentEntity;

  const CommentArticleEvent(
      this.articleId, this.userId, this.articleCommentEntity);

  @override
  List<Object?> get props => [articleId, userId, articleCommentEntity];
}

final class ReplyCommentArticleEvent extends ArticleEvent {
  final int articleId;
  final int userId;
  final ArticleCommentEntity articleCommentEntity;

  const ReplyCommentArticleEvent(
      this.articleId, this.userId, this.articleCommentEntity);

  @override
  List<Object?> get props => [articleId, userId, articleCommentEntity];
}

final class GetArticleByIdEvent extends ArticleEvent {
  final int articleId;

  const GetArticleByIdEvent(this.articleId);

  @override
  // TODO: implement props
  List<Object?> get props => [articleId];
}

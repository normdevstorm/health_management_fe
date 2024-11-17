import 'package:equatable/equatable.dart';
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

import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/articles/repositories/article_repository.dart';

class ArticleUsecase {
  final ArticleRepository _repository;

  ArticleUsecase(this._repository);

  Future<List<ArticleEntity>> getAllArticle() async {
    return _repository.getAllArticle();
  }

  Future<List<ArticleEntity>> getAllArticleByUserId(int userId) async {
    return _repository.getAllArticleByUserId(userId);
  }

  Future<ArticleEntity> createArticle(
      ArticleEntity articleEntity, int userId) async {
    return _repository.createArticle(articleEntity, userId);
  }

  Future<ArticleEntity> updateArticle(
      ArticleEntity articleEntity, int userId) async {
    return _repository.updateArticle(articleEntity, userId);
  }

  Future<String> deleteArticle(int articleId, int userId) async {
    return _repository.deleteArticle(articleId, userId);
  }

  Future<String> voteArticle(
      int articleId, int userId, VoteType voteType) async {
    return _repository.voteArticle(articleId, userId, voteType);
  }

  Future<ArticleCommentEntity> commentArticle(int articleId, int userId,
      ArticleCommentEntity articleCommentEntity) async {
    return _repository.commentArticle(articleId, userId, articleCommentEntity);
  }

  Future<ArticleEntity> getArticleById(int id) async {
    return _repository.getArticleById(id);
  }
}

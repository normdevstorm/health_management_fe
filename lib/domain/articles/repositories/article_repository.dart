import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getAllArticle();
  Future<List<ArticleEntity>> getAllArticleByUserId(int userId);
  Future<ArticleEntity> getArticleById(int id);
  Future<ArticleEntity> createArticle(ArticleEntity articleEntity, int userId);
  Future<ArticleEntity> updateArticle(ArticleEntity articleEntity, int userId);
  Future<String> deleteArticle(int articleId, int userId);
  Future<ArticleCommentEntity> commentArticle(
      int articleId, int userId, ArticleCommentEntity articleCommentEntity);
  Future<String> voteArticle(int articleId, int userId, VoteType voteType);
}

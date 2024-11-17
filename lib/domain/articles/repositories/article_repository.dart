import 'package:health_management/domain/articles/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getAllArticle();
  Future<List<ArticleEntity>> getAllArticleByUserId(int userId);
  Future<ArticleEntity> createArticle(ArticleEntity articleEntity, int userId);
  Future<ArticleEntity> updateArticle(ArticleEntity articleEntity, int userId);
  Future<String> deleteArticle(int articleId, int userId);
}

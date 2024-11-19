import 'dart:convert';

import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/articles/api/articles_api.dart';
import 'package:health_management/data/articles/models/request/article_request.dart';
import 'package:health_management/data/articles/models/response/articles_response.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/articles/repositories/article_repository.dart';
import 'package:logger/logger.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticlesApi api;
  final Logger logger;

  const ArticleRepositoryImpl(this.api, this.logger);

  @override
  Future<ArticleEntity> createArticle(
      ArticleEntity articleEntity, int userId) async {
    try {
      final response = await api.createArticle(
          ArticleRequest.fromEntity(articleEntity), userId);
      return response.data?.toEntity() ?? ArticleEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<String> deleteArticle(int articleId, int userId) async {
    try {
      final response = await api.deleteArticle(articleId, userId);
      return response.data!;
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getAllArticleByUserId(int userId) async {
    try {
      final response = await api.getAllArticlesByUserId(userId);
      logger.d(response.data); // Kiểm tra dữ liệu JSON gốc
      logger.d(response.data.runtimeType);
      return (response.data ?? []).map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<ArticleEntity> updateArticle(
      ArticleEntity articleEntity, int userId) async {
    try {
      final response = await api.updateArticle(
          ArticleRequest.fromEntity(articleEntity), userId);
      return response.data?.toEntity() ?? ArticleEntity();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getAllArticle() async {
    try {
      final response = await api.getAllArticles();
      return (response.data ?? []).map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      throw ApiException.getDioException(e);
    }
  }
}

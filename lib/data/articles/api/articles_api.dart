import 'package:dio/dio.dart';
import 'package:health_management/data/articles/models/request/article_comment_request.dart';
import 'package:health_management/data/articles/models/request/article_request.dart';
import 'package:health_management/data/articles/models/response/articles_comment_response.dart';
import 'package:health_management/data/articles/models/response/articles_response.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'articles_api.g.dart';

@RestApi()
abstract class ArticlesApi {
  factory ArticlesApi(Dio dio, {String baseUrl}) = _ArticlesApi;
  @GET('/articles/get-all')
  Future<ApiResponse<List<ArticlesResponse>>> getAllArticles();
  @GET('/articles/get-by-id')
  Future<ApiResponse<ArticlesResponse>> getArticleById(@Query('id') int id);
  @GET('/articles/get-by-user-id')
  Future<ApiResponse<List<ArticlesResponse>>> getAllArticlesByUserId(
      @Query('userId') int userId);
  @POST('/articles/create')
  Future<ApiResponse<ArticlesResponse>> createArticle(
      @Body() ArticleRequest article, @Query('userId') int userId);
  @DELETE('/articles/delete')
  Future<ApiResponse<String>> deleteArticle(
      @Query('id') int articleId, @Query('userId') int userId);
  @POST('/articles/update')
  Future<ApiResponse<ArticlesResponse>> updateArticle(
      @Body() ArticleRequest article, @Query('userId') int userId);
  @POST('/articles/comment')
  Future<ApiResponse<ArticlesCommentResponse>> commentArticle(
      @Query('articleId') int articleId,
      @Query('userId') int userId,
      @Body() ArticleCommentRequest articleCommentRequest);
  @POST('/articles/vote')
  Future<ApiResponse<String>> voteArticle(@Query('article_id') int articleId,
      @Query('user_id') int userId, @Query('vote_type') String voteType);
}

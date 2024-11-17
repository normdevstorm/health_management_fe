import 'package:dio/dio.dart';
import 'package:health_management/data/articles/models/request/article_request.dart';
import 'package:health_management/data/articles/models/response/articles_response.dart';
import 'package:health_management/data/common/api_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'articles_api.g.dart';

@RestApi()
abstract class ArticlesApi {
  factory ArticlesApi(Dio dio, {String baseUrl}) = _ArticlesApi;
  @GET('/health-articles/get-all')
  Future<ApiResponse<List<ArticlesResponse>>> getAllArticles();
  @GET('/health-articles/get-by-user-id')
  Future<ApiResponse<List<ArticlesResponse>>> getAllArticlesByUserId(
      @Query('userId') int userId);
  @POST('/health-articles/create')
  Future<ApiResponse<ArticlesResponse>> createArticle(
      @Body() ArticleRequest article, @Query('userId') int userId);
  @DELETE('/health-articles/delete/{userId}')
  Future<ApiResponse<String>> deleteArticle(
      @Path('id') int articleId, @Path('userId') int userId);
  @PUT('/health-articles/update')
  Future<ApiResponse<ArticlesResponse>> updateArticle(
      @Body() ArticleRequest article, @Query('userId') int userId);
}

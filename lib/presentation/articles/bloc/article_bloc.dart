import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/articles/entities/article_media_entity.dart';
import 'package:health_management/domain/articles/usecases/article_usecase.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleUsecase articleUsecase;
  final usecase = getIt<UserUseCase>();

  ArticleBloc({required this.articleUsecase}) : super(ArticleState.initial()) {
    on<GetAllArticleByUserIdEvent>(
        (event, emit) => _onGetAllArticleByUserIdEvent(event, emit));
    on<CreateArticleEvent>((event, emit) => _onCreateArticleEvent(event, emit));
    on<GetAllArticleEvent>((event, emit) => _onGetAllArticle(event, emit));
    on<CommentArticleEvent>((event, emit) => _onCommentArticle(event, emit));
    on<ReplyCommentArticleEvent>(
        (event, emit) => _onReplyCommentArticle(event, emit));
    on<DeleteArticleEvent>((event, emit) => _onDeleteArticleEvent(event, emit));
    on<UpdateArticleEvent>((event, emit) => _onUpdateArticleEvent(event, emit));
    on<GetArticleByIdEvent>((event, emit) => _onGetArticleById(event, emit));
    on<VoteArticleEvent>((event, emit) => _onVoteArticleEvent(event, emit));
  }

  _onGetAllArticle(GetAllArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final article = await articleUsecase.getAllArticle();
      emit(ArticleState.success(article));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onGetAllArticleByUserIdEvent(
      GetAllArticleByUserIdEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final article = await articleUsecase.getAllArticleByUserId(event.userId);
      emit(ArticleState.success(article));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onCreateArticleEvent(
      CreateArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final List<String> urls = await usecase.uploadImageToFirebase(
          event.imgPaths, UploadImageType.article);
      final List<ArticleMediaEntity> listMedia = [];
      for (var element in urls) {
        listMedia.add(ArticleMediaEntity(url: element, type: MediaType.image));
      }
      final article = await articleUsecase.createArticle(
          event.articleEntity.copyWith(media: listMedia), event.userId);

      emit(ArticleState.success(article));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onDeleteArticleEvent(
      DeleteArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final article =
          await articleUsecase.deleteArticle(event.articleId, event.userId);
      emit(ArticleState.success(article));
      // Phát sự kiện để lấy lại danh sách bài viết
      add(GetAllArticleByUserIdEvent(userId: event.userId));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onUpdateArticleEvent(
      UpdateArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final articleUpdate =
          await articleUsecase.updateArticle(event.articleEntity, event.userId);
      final articles = await articleUsecase.getAllArticleByUserId(event.userId);
      emit(ArticleState.success(articles));
      // Phát sự kiện để lấy lại danh sách bài viết
      add(GetAllArticleByUserIdEvent(userId: event.userId));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onCommentArticle(
      CommentArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      await articleUsecase.commentArticle(
          event.articleId, event.userId, event.articleCommentEntity);
      final article = await articleUsecase.getArticleById(event.articleId);
      emit(ArticleState.success(article.comments));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onReplyCommentArticle(
      ReplyCommentArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      await articleUsecase.commentArticle(
          event.articleId, event.userId, event.articleCommentEntity);
      final article = await articleUsecase.getArticleById(event.articleId);
      emit(ArticleState.success(article.comments));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onGetArticleById(
      GetArticleByIdEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final article = await articleUsecase.getArticleById(event.articleId);
      emit(ArticleState.success(article));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }

  _onVoteArticleEvent(
      VoteArticleEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleState.loading());
    try {
      final response = await articleUsecase.voteArticle(
          event.articleId, event.userId, event.voteType);
      final article = await articleUsecase.getArticleById(event.articleId);
      final voteData = <String, int?>{
        "up_vote": article.upVoteCount,
        "down_vote": article.downVoteCount
      };
      emit(ArticleState.success(voteData));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }
}

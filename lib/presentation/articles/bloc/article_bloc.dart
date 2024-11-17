import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/domain/articles/usecases/article_usecase.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleUsecase articleUsecase;

  ArticleBloc({required this.articleUsecase}) : super(ArticleState.initial()) {
    on<GetAllArticleByUserIdEvent>(
        (event, emit) => _onGetAllArticleByUserIdEvent(event, emit));
    on<CreateArticleEvent>((event, emit) => _onCreateArticleEvent(event, emit));
    on<GetAllArticleEvent>((event, emit) => _onGetAllArticle(event, emit));
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
      final article =
          await articleUsecase.createArticle(event.articleEntity, event.userId);
      emit(ArticleState.success(article));
    } catch (e) {
      emit(ArticleState.error(e.toString()));
    }
  }
}

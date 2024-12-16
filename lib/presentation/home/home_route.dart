import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/articles/ui/article_detail_screen.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:health_management/presentation/home/ui/article_home_screen.dart';
import '../../app/di/injection.dart';
import '../../app/route/route_define.dart';
import '../../domain/articles/usecases/article_usecase.dart';
import '../../domain/doctor/usecases/doctor_usecase.dart';
import '../articles/bloc/article_bloc.dart';
import '../articles/bloc/article_event.dart';
import 'bloc/home_bloc.dart';
part 'home_route.g.dart';

@TypedShellRoute<HomeRoute>(
  routes: [
    TypedGoRoute<HomeScreenRoute>(
        path: "/home",
        name: RouteDefine.homeScreen,
        routes: [
          TypedGoRoute<ArticleDetailsRoute>(
              path: "/article-details/:articleId",
              name: RouteDefine.articleDetails,
              routes: []),
        ]),
  ],
)
class HomeRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(
            articleUsecase: getIt<ArticleUsecase>(),
          ),
        ),
        BlocProvider(
            create: (context) =>
                HomeBloc(doctorUseCase: getIt<DoctorUseCase>())),
      ],
      child: navigator,
    );
  }
}

class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ArticleHome(title: "Article Home");
  }
}

class ArticleDetailsRoute extends GoRouteData {
  final String articleId;
  ArticleDetailsRoute({required this.articleId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final int articleId =
        int.tryParse(state.pathParameters['articleId'] ?? '0') ?? 0;
    final int userId = state.extra as int;
    return BlocProvider<ArticleBloc>.value(
      value: BlocProvider.of<ArticleBloc>(context)
        ..add(GetArticleByIdEvent(articleId)),
      child: ArticleDetailScreen(
        articleId: articleId,
        userId: userId,
      ),
    );
  }
}

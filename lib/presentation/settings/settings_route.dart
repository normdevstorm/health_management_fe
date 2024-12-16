import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/articles/ui/article_screen.dart';
import 'package:health_management/presentation/edit_profile/ui/edit_profile_screen.dart';
import 'package:health_management/presentation/settings/ui/screen/settings_screen.dart';
import '../../domain/articles/usecases/article_usecase.dart';
import '../articles/bloc/article_bloc.dart';
import '../articles/bloc/article_event.dart';
import '../articles/ui/article_detail_screen.dart';
import '../chat/bloc/profile/profile_cubit.dart';
import '../chat/bloc/user/user_cubit.dart';
import '../edit_profile/ui/avatar_preview_screen.dart';
part 'settings_route.g.dart';

@TypedShellRoute<SettingsRoute>(routes: [
  TypedGoRoute<SettingScreenRoute>(
      path: '/settings',
      name: RouteDefine.settings,
      routes: [
        TypedGoRoute<ProfileRoute>(
            path: '/edit-profile',
            name: RouteDefine.editProfile,
            routes: [
              TypedGoRoute<AvatarPreviewRoute>(
                path: '/avatar-preview',
                name: RouteDefine.avatarPreview,
              )
            ]),
        TypedGoRoute<SettingArticleRoute>(
            path: "/article",
            name: RouteDefine.article,
            routes: [
              TypedGoRoute<SettingArticleDetailRoute>(
                  path: "/article-details/:articleId",
                  name: RouteDefine.articleSetting,
                  routes: []),
            ]),
      ]),
])
class SettingsRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ArticleBloc(articleUsecase: getIt<ArticleUsecase>()),
        ),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: navigator,
    );
  }
}

class AvatarPreviewRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final imageFile = state.extra as File;
    return AvatarPreviewScreen(
      imageFile: imageFile,
    );
  }
}

class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditProfileScreen();
  }
}

class SettingScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

class SettingArticleRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ArticleScreen();
  }
}

class SettingArticleDetailRoute extends GoRouteData {
  final String articleId;
  SettingArticleDetailRoute({required this.articleId});
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

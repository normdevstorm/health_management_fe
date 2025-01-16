import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/article_create_screen.dart';
import 'package:health_management/presentation/articles/ui/article_update_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late int? userId; // Biến để lưu userId
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final user =
          await SharedPreferenceManager.getUser(); // Lấy thông tin user
      if (user != null) {
        setState(() {
          userId = user.id; // Gán userId vào biến state
        });
        context
            .read<ArticleBloc>()
            .add(GetAllArticleByUserIdEvent(userId: userId!));
      } else {
        // Xử lý khi không có thông tin user
        ToastManager.showToast(
            context: context, message: 'Error fetching user: User not found');
      }
    } catch (e) {
      // Xử lý lỗi
      ToastManager.showToast(
          context: context, message: 'Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        buildWhen: (previous, current) =>
            previous.status != current.status &&
            (current.data.runtimeType == List<ArticleEntity>),
        builder: (context, state) {
          if (state.status == BlocStatus.loading) {
            return const Center(
                child: CircularProgressIndicator(
              value: 25,
            ));
          }

          if (state.status == BlocStatus.error) {
            return Center(child: Text(state.errorMessage.toString()));
          }

          if (state.status == BlocStatus.success) {
            List<ArticleEntity> articles;
            try {
              articles = state.data as List<ArticleEntity>;
              articles.sort((a, b) =>
                  a.title
                      ?.toUpperCase()
                      .compareTo(b.title?.toUpperCase() ?? "") ??
                  0);
            } catch (e) {
              // TODO
              articles = [];
            }

            return ListView.builder(
              itemCount: articles.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: context.read<ArticleBloc>(),
                                child: const ArticleCreateScreen(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.article, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Create New Article",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return ArticleItem(
                  article: articles[index - 1],
                  userId: userId,
                );
              },
            );
          }

          return const Center(child: Text('No articles found'));
        },
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  final ArticleEntity article;
  final int? userId; // Thêm userId

  const ArticleItem({super.key, required this.article, this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author and Avatar
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(article.userAvatar.toString()),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      article.username.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    if (article.userId == userId)
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'update') {
                            _navigateToUpdateArticle(context, article);
                          } else if (value == 'delete') {
                            _deleteArticle(
                                context, article.id!, article.userId!);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'update',
                            child: Text('Update'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Title and Category with menu button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        article.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                // Content preview
                Text(
                  article.content.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Vote, Comment, View Counts

                BlocBuilder<ArticleBloc, ArticleState>(
                  buildWhen: (previous, current) =>
                      current.data != previous.data,
                  builder: (context, state) {
                    final upVoteCount = (state.data == Map<String, int?>)
                        ? (state.data as Map<String, int?>)["up_vote"]
                        : article.upVoteCount;
                    final downVoteCount = (state.data == Map<String, int?>)
                        ? (state.data as Map<String, int?>)["down_vote"]
                        : article.downVoteCount;
                    final commentCount =
                        (state.data == List<ArticleCommentEntity>)
                            ? (state.data as List<ArticleCommentEntity>).length
                            : article.commentCount;
                    final viewCount = article.viewCount;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.thumb_up,
                                size: 16, color: Colors.black),
                            const SizedBox(width: 4),
                            Text('${upVoteCount ?? 0}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.thumb_down,
                                size: 16, color: Colors.black),
                            const SizedBox(width: 4),
                            Text('${downVoteCount ?? 0}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.comment,
                                size: 16, color: Colors.black),
                            const SizedBox(width: 4),
                            Text('${commentCount ?? 0}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.visibility,
                                size: 16, color: Colors.black),
                            const SizedBox(width: 4),
                            Text('${viewCount ?? 0}'),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          if (article.id != null) {
            _navigateToArticleDetail(context, article.id!, userId ?? 0);
          }
          return;
        });
  }

  void _navigateToUpdateArticle(BuildContext context, ArticleEntity article) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        // Tạo Popup Dialog
        return BlocProvider<ArticleBloc>.value(
          value: context.read<ArticleBloc>(),
          child: UpdateArticleDialog(article: article),
        );
      },
    );

    // Fetch lại danh sách bài viết sau khi đóng dialog
    context
        .read<ArticleBloc>()
        .add(GetAllArticleByUserIdEvent(userId: article.userId!));
  }

  void _deleteArticle(BuildContext context, int articleId, int userId) {
    context.read<ArticleBloc>().add(DeleteArticleEvent(articleId, userId));
    ToastManager.showToast(context: context, message: 'Article deleted!');
    context
        .read<ArticleBloc>()
        .add(GetAllArticleByUserIdEvent(userId: article.userId!));
  }

  void _navigateToArticleDetail(
      BuildContext context, int articleId, int userId) {
    bool isFromHome =
        GoRouter.of(context).state?.matchedLocation.startsWith('/home') ?? true;
    context.pushNamed(
        isFromHome ? RouteDefine.articleDetails : RouteDefine.articleSetting,
        pathParameters: {
          'articleId': articleId.toString(),
        },
        extra: userId);
  }
}

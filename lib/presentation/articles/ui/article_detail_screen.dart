import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/widgets/comment_tree_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int articleId;

  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool isCommenting = false;
  final TextEditingController _commentController = TextEditingController();
  late final article = "";

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleCommenting() {
    setState(() {
      isCommenting = !isCommenting;
    });
  }

  void _sendComment() {
    final commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      try {
        final commentEntity = ArticleCommentEntity(
          articleId: widget.articleId,
          userId: 2,
          content: commentText,
        );

        context
            .read<ArticleBloc>()
            .add(CommentArticleEvent(widget.articleId ?? 0, 2, commentEntity));
        _commentController.clear();
        _toggleCommenting();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending comment: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment cannot be empty!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<ArticleBloc>().add(const GetAllArticleEvent());
      },
      child: BlocConsumer<ArticleBloc, ArticleState>(
          listenWhen: (previous, current) =>
              (current.data.runtimeType == ArticleEntity &&
                  current.status == BlocStatus.success) ||
              current.status == BlocStatus.error,
          listener: (context, state) async {
            if (state.status == BlocStatus.success) {
              ToastManager.showToast(
                  message: "Article loaded successfully", context: context);
              _toggleCommenting();
            } else if (state.status == BlocStatus.error) {
              ToastManager.showToast(
                  context: context,
                  message: state.errorMessage ?? "Error loading article");
            }
          },
          buildWhen: (previous, current) =>
              current.data.runtimeType == ArticleEntity,
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return const Center(child: CircularProgressIndicator(value: 8));
            }
            if (state.status == BlocStatus.success) {
              ArticleEntity data;
              try {
                data = state.data as ArticleEntity;
              } catch (e) {
                data = const ArticleEntity();
                // TODO
              }
              return Scaffold(
                  appBar: AppBar(
                    title: Text(data.title ?? "Article Detail"),
                  ),
                  body: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.all(16.0),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                // Title and content of the article
                                Text(
                                  data.title ?? "Untitled",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(data.content ?? "No content available."),
                                const Divider(height: 32, thickness: 1),
                                // Stats and comment button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround, // Đảm bảo khoảng cách đều nhau cho toàn bộ nút
                                  children: [
                                    // Nút Vote
                                    BlocBuilder<ArticleBloc, ArticleState>(
                                      buildWhen: (previous, current) =>
                                          current.data is Map<String, int?>,
                                      builder: (context, state) {
                                        final upVoteCount = (state.data
                                                is Map<String, int?>)
                                            ? (state.data
                                                as Map<String, int?>)["up_vote"]
                                            : data.upVoteCount;

                                        return _stateWidget(
                                          Icons.thumb_up,
                                          upVoteCount ?? 0,
                                          context,
                                          () => context.read<ArticleBloc>().add(
                                                VoteArticleEvent(
                                                    widget.articleId,
                                                    2,
                                                    VoteType.upvote),
                                              ),
                                        );
                                      },
                                    ),
                                    // Nút Unvote
                                    BlocBuilder<ArticleBloc, ArticleState>(
                                      buildWhen: (previous, current) =>
                                          current.data is Map<String, int?>,
                                      builder: (context, state) {
                                        final downVoteCount = (state.data
                                                is Map<String, int?>)
                                            ? (state.data as Map<String, int?>)[
                                                "down_vote"]
                                            : data.downVoteCount;

                                        return _stateWidget(
                                          Icons.thumb_down,
                                          downVoteCount ?? 0,
                                          context,
                                          () => context.read<ArticleBloc>().add(
                                                VoteArticleEvent(
                                                    widget.articleId,
                                                    2,
                                                    VoteType.downvote),
                                              ),
                                        );
                                      },
                                    ),
                                    // Nút Comment
                                    BlocBuilder<ArticleBloc, ArticleState>(
                                      buildWhen: (previous, current) =>
                                          current.data.runtimeType ==
                                          List<ArticleCommentEntity>,
                                      builder: (context, state) {
                                        final commentCount =
                                            (state.data.runtimeType ==
                                                    List<ArticleCommentEntity>)
                                                ? (state.data as List<
                                                        ArticleCommentEntity>)
                                                    .length
                                                : data.commentCount;

                                        return GestureDetector(
                                          onTap: _toggleCommenting,
                                          child: _stateWidget(
                                            Icons.comment,
                                            commentCount ?? 0,
                                            context,
                                            () {},
                                          ),
                                        );
                                      },
                                    ),
                                    // Nút View
                                    _stateWidget(
                                      Icons.remove_red_eye,
                                      data.viewCount ?? 0,
                                      context,
                                      () {},
                                    ),
                                  ],
                                ),

                                const Divider(height: 32, thickness: 1),
                                // Comment list
                                if (data.comments != null &&
                                    data.comments!.isNotEmpty)
                                  BlocBuilder<ArticleBloc, ArticleState>(
                                    buildWhen: (previous, current) =>
                                        current.data.runtimeType ==
                                        List<ArticleCommentEntity>,
                                    builder: (context, state) {
                                      final commentList =
                                          (state.data.runtimeType ==
                                                  List<ArticleCommentEntity>)
                                              ? state.data
                                                  as List<ArticleCommentEntity>
                                              : data.comments!;
                                      return CommentTree(
                                        comments:
                                            List<ArticleCommentEntity>.from(
                                                commentList),
                                      );
                                    },
                                  )
                                else
                                  const Center(child: Text("No comments yet")),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      // Comment input field
                      if (isCommenting)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _commentController,
                                    decoration: const InputDecoration(
                                      hintText: 'Write a comment...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: _sendComment,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ));
            }
            return const SizedBox();
          }),
    );
  }
}

Widget _stateWidget(
    IconData icon, int count, BuildContext context, VoidCallback? onTap) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
          onTap: onTap, child: Icon(icon, size: 24, color: Colors.black)),
      const SizedBox(height: 4),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

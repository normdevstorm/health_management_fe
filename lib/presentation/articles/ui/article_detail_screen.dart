import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/widgets/comment_tree_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int articleId;
  final int? userId;
  const ArticleDetailScreen({super.key, required this.articleId, this.userId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool isCommenting = false;
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _commentNotifier = ValueNotifier(false);
  late final article = "";
  var upvoteList = <int>[];
  var downvoteList = <int>[];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _sendComment() async {
    final commentText = _commentController.text.trim();
    final user = await SharedPreferenceManager.getUser();
    if (commentText.isNotEmpty) {
      try {
        final commentEntity = ArticleCommentEntity(
          articleId: widget.articleId,
          userId: user?.id,
          content: commentText,
        );

        context.read<ArticleBloc>().add(CommentArticleEvent(
            widget.articleId ?? 0, user?.id ?? 2, commentEntity));
        _commentController.clear();
        _commentNotifier.value = false;
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

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 30,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
              ArticleEntity? data;
              try {
                if (state.data is List<ArticleEntity>) {
                  List<ArticleEntity> result =
                      state.data as List<ArticleEntity>;
                  data = result.firstWhere(
                    (e) {
                      return e.id! == widget.articleId;
                    },
                  );
                } else if (state.data is ArticleEntity) {
                  data = state.data as ArticleEntity;
                } else {
                  data = const ArticleEntity();
                }
              } catch (e) {
                data = const ArticleEntity();
                // TODO: Handle the error appropriately
              } finally {
                data?.votes?.forEach((element) {
                  if (element.type == VoteType.upvote) {
                    upvoteList.add(element.userId!);
                  } else {
                    downvoteList.add(element.userId!);
                  }
                });
              }

              // Use the `data` variable as needed
              return Scaffold(
                  appBar: AppBar(
                    title: Text(data.title ?? "Article Detail"),
                  ),
                  body: Stack(
                    children: [
                      CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0, bottom: 30),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                // Title and content of the article

                                FutureBuilder(
                                    future: SharedPreferenceManager.getUser(),
                                    builder: (context, snapshot) {
                                      // final ava = snapshot.data?.avatarUrl;
                                      // final username = snapshot.data?.firstName;
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.data != null) {
                                        return GestureDetector(
                                          onTap: () {
                                            _showUserPopup(
                                                context, snapshot.data);
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      data?.userAvatar ?? "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                data?.username ?? "Guest",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.title ?? "Untitled",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                Text(data.content ?? "No content available."),
                                const SizedBox(height: 8),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: ((data.media ?? []).isEmpty ||
                                            data.media!.first.url == null)
                                        ? "assets/images/placeholder.png"
                                        : data.media!.first.url!,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/placeholder.png',
                                      fit: BoxFit.cover,
                                    ),
                                    height: 400,
                                  ),
                                ),
                                const Divider(height: 20, thickness: 1),
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
                                            : data?.upVoteCount;

                                        return FutureBuilder<UserEntity?>(
                                          future:
                                              SharedPreferenceManager.getUser(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            }

                                            if (snapshot.hasError ||
                                                !snapshot.hasData) {
                                              return const Center(
                                                  child: Text(
                                                      "Lỗi khi lấy thông tin người dùng!"));
                                            }

                                            final userId = snapshot.data
                                                ?.id; // Lấy ID người dùng từ UserEntity
                                            if (userId == null) {
                                              return const Center(
                                                  child: Text(
                                                      "Không tìm thấy thông tin người dùng!"));
                                            }

                                            var isUserUpvoted =
                                                upvoteList.contains(userId);
                                            return _stateWidget(
                                                Icons.thumb_up,
                                                upVoteCount ?? 0,
                                                colorSelected: Colors.blue,
                                                isSelected: isUserUpvoted,
                                                context, () {
                                              if (isUserUpvoted) {
                                                upvoteList.remove(userId);
                                              } else {
                                                downvoteList.remove(userId);
                                                upvoteList.add(userId);
                                              }
                                              context.read<ArticleBloc>().add(
                                                    VoteArticleEvent(
                                                        widget.articleId,
                                                        userId,
                                                        VoteType.upvote),
                                                  );
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    // Nút Unvote
                                    BlocBuilder<ArticleBloc, ArticleState>(
                                      buildWhen: (previous, current) =>
                                          current.data is Map<String, int?>,
                                      builder: (context, state) {
                                        final downvoteCount = (state.data
                                                is Map<String, int?>)
                                            ? (state.data as Map<String, int?>)[
                                                "down_vote"]
                                            : data?.downVoteCount;

                                        return FutureBuilder<UserEntity?>(
                                          future:
                                              SharedPreferenceManager.getUser(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            }

                                            if (snapshot.hasError ||
                                                !snapshot.hasData) {
                                              return const Center(
                                                  child: Text(
                                                      "Lỗi khi lấy thông tin người dùng!"));
                                            }

                                            final userId = snapshot.data
                                                ?.id; // Lấy ID người dùng từ UserEntity
                                            if (userId == null) {
                                              return const Center(
                                                  child: Text(
                                                      "Không tìm thấy thông tin người dùng!"));
                                            }

                                            var isUserDownvoted =
                                                downvoteList.contains(userId);
                                            return _stateWidget(
                                                Icons.thumb_down,
                                                downvoteCount ?? 0,
                                                colorSelected: Colors.red,
                                                isSelected: isUserDownvoted,
                                                context, () {
                                              if (isUserDownvoted) {
                                                downvoteList.remove(userId);
                                              } else {
                                                upvoteList.remove(userId);
                                                downvoteList.add(userId);
                                              }
                                              context.read<ArticleBloc>().add(
                                                    VoteArticleEvent(
                                                        widget.articleId,
                                                        userId,
                                                        VoteType.downvote),
                                                  );
                                            });
                                          },
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
                                                : data?.commentCount;

                                        return _stateWidget(
                                          Icons.comment,
                                          commentCount ?? 0,
                                          context,
                                          () {
                                            _commentNotifier.value = true;
                                          },
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
                                // if (data.comments != null &&
                                //     data.comments!.isNotEmpty)
                                BlocConsumer<ArticleBloc, ArticleState>(
                                  listener: (context, state) {
                                    if (state.status == BlocStatus.success &&
                                        state.data.runtimeType ==
                                            List<ArticleCommentEntity>) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        _scrollToEnd();
                                      });
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                      (current.data.runtimeType ==
                                          List<ArticleCommentEntity>) &&
                                      previous.status != current.status,
                                  builder: (context, state) {
                                    final List<ArticleCommentEntity>?
                                        commentList = (state.data.runtimeType ==
                                                List<ArticleCommentEntity>)
                                            ? state.data
                                                as List<ArticleCommentEntity>
                                            : data?.comments;

                                    return (commentList != null &&
                                            commentList.isNotEmpty)
                                        ? CommentTree(comments: commentList)
                                        : const Center(
                                            child: Text("No comments yet"));
                                  },
                                )
                                // else
                                //   const Center(child: Text("No comments yet")),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      // Comment input field

                      ValueListenableBuilder(
                        valueListenable: _commentNotifier,
                        builder: (context, showCommentBox, child) =>
                            showCommentBox
                                ? Align(
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
                                  )
                                : const SizedBox(),
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
    IconData icon, int count, BuildContext context, VoidCallback? onTap,
    {bool isSelected = false, Color? colorSelected}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
          onTap: onTap,
          child: Icon(icon,
              size: 24, color: isSelected ? colorSelected : Colors.black)),
      const SizedBox(height: 4),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

void _showUserPopup(BuildContext context, dynamic userData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      userData.avatarUrl ?? "/assets/images/placeholder.png"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.firstName + " " + userData.lastName ?? "Guest",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Role: ${userData.account.role}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.email, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    userData.account.email ?? "No email available",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    userData.account.phone ?? "No phone number available",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                userData.gender == "MALE"
                    ? const Icon(Icons.male_outlined,
                        size: 20, color: Colors.grey)
                    : const Icon(Icons.female_outlined,
                        size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    userData.gender ?? "Gender",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

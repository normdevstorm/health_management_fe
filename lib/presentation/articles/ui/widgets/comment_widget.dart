import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';

class CommentWidget extends StatefulWidget {
  final ArticleCommentEntity comment;

  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool isReplying = false;
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _toggleReplying() {
    setState(() {
      isReplying = !isReplying;
    });
  }

  void _sendReply(int commentId) async {
    final user = await SharedPreferenceManager.getUser();
    final replyText = _replyController.text.trim();
    if (replyText.isNotEmpty) {
      final reply = ArticleCommentEntity(
          articleId: widget.comment.articleId,
          userId: user?.id,
          username: user?.firstName,
          content: replyText,
          parentId: commentId);

      // Gửi sự kiện đến Bloc
      context.read<ArticleBloc>().add(
            ReplyCommentArticleEvent(
                widget.comment.articleId!, user?.id ?? 0, reply),
          );
      // Dọn dẹp UI
      _replyController.clear();
      _toggleReplying();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar người dùng
              CircleAvatar(
                backgroundImage: NetworkImage(widget.comment.userAvatar ?? ""),
                radius: 20,
              ),
              const SizedBox(width: 10),
              // Username và Nội dung
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.username ?? "Unknown",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.comment.content ?? "No content",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Thống kê (Upvote, Downvote, Reply)
          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Row(
              children: [
                _actionButton(Icons.thumb_up, widget.comment.upvoteCount ?? 0),
                const SizedBox(width: 16),
                _actionButton(
                    Icons.thumb_down, widget.comment.downvoteCount ?? 0),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _toggleReplying,
                  child: const Row(
                    children: [
                      Icon(Icons.reply, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "Reply",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Phần ô nhập trả lời (khi người dùng nhấn Reply)
          if (isReplying)
            Padding(
              padding: const EdgeInsets.only(left: 48.0, top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      decoration: const InputDecoration(
                        hintText: "Write a reply...",
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () => _sendReply(widget.comment.id ?? 0),
                  ),
                ],
              ),
            ),

          // Phần replies (nếu có)
          if (widget.comment.replies != null &&
              (widget.comment.replies as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Column(
                children: (widget.comment.replies as List)
                    .map((reply) => CommentWidget(comment: reply))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

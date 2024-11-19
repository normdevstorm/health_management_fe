import 'package:flutter/material.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';

class CommentWidget extends StatelessWidget {
  final ArticleCommentEntity comment;

  const CommentWidget({super.key, required this.comment});

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
                backgroundImage: NetworkImage(comment.userAvatar ?? ""),
                radius: 20,
              ),
              const SizedBox(width: 10),
              // Username và Nội dung
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName ?? "Unknown",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.content ?? "No content",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Thống kê (Upvote, Downvote)
          Row(
            children: [
              _actionButton(Icons.thumb_up, comment.upvoteCount ?? 0),
              const SizedBox(width: 16),
              _actionButton(Icons.thumb_down, comment.downvoteCount ?? 0),
            ],
          ),

          // Phần replies (nếu có)
          if (comment.replies != null && (comment.replies as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Column(
                children: (comment.replies as List)
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

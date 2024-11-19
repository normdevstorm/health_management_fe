import 'package:flutter/material.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/presentation/articles/ui/widgets/comment_tree_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title ?? "Article Detail"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Tiêu đề
                Text(
                  widget.article.title ?? "Untitled",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),

                // Thông tin người viết
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.article.userAvatar != null &&
                              widget.article.userAvatar!.isNotEmpty
                          ? NetworkImage(widget.article.userAvatar!)
                          : null,
                      radius: 24,
                      child: widget.article.userAvatar == null
                          ? const Icon(Icons.person, size: 24)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.article.userName ?? "Unknown",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Nội dung bài viết
                Text(
                  widget.article.content ?? "No content available.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),

                // Media nếu có
                if (widget.article.media != null &&
                    widget.article.media!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Media",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                        widget.article.media!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.network(
                            widget.article.media![index].url ?? "",
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 48),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),

                // Category
                Chip(
                  label: Text(
                    widget.article.category?.name ?? "Uncategorized",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  backgroundColor: const Color.fromARGB(255, 233, 238, 240),
                ),
                const SizedBox(height: 16),

                // Thống kê bài viết
                const Divider(height: 32, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _stateWidget(
                        Icons.thumb_up, widget.article.upVoteCount ?? 0),
                    _stateWidget(
                        Icons.thumb_down, widget.article.downVoteCount ?? 0),
                    _stateWidget(
                        Icons.comment, widget.article.commentCount ?? 0),
                    _stateWidget(
                        Icons.remove_red_eye, widget.article.viewCount ?? 0),
                  ],
                ),
                const Divider(height: 32, thickness: 1),

                // Phần hiển thị danh sách bình luận
                if (widget.article.comments != null &&
                    widget.article.comments!.isNotEmpty)
                  CommentTree(
                    comments: List<ArticleCommentEntity>.from(
                        widget.article.comments!),
                  )
                else
                  const Center(
                    child: Text("No comments yet"),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateWidget(IconData icon, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

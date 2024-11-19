import 'package:flutter/material.dart';
import 'package:health_management/domain/articles/entities/article_comment_entity.dart';
import 'package:health_management/presentation/articles/ui/widgets/comment_widget.dart';

class CommentTree extends StatelessWidget {
  final List<ArticleCommentEntity> comments;

  const CommentTree({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          comments.map((comment) => CommentWidget(comment: comment)).toList(),
    );
  }
}

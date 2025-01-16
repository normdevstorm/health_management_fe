import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/managers/toast_manager.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';

class UpdateArticleDialog extends StatefulWidget {
  final ArticleEntity article;

  const UpdateArticleDialog({super.key, required this.article});

  @override
  State<UpdateArticleDialog> createState() => _UpdateArticleDialogState();
}

class _UpdateArticleDialogState extends State<UpdateArticleDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Gán dữ liệu ban đầu từ article
    _titleController = TextEditingController(text: widget.article.title);
    _contentController = TextEditingController(text: widget.article.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Article"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input cho Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Input cho Content
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Content",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Nút Cancel
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        // Nút Update
        ElevatedButton(
          onPressed: () {
            // Tạo một bản sao mới của ArticleEntity với các giá trị được cập nhật
            final updatedArticle = widget.article.copyWith(
              id: widget.article.id,
              title: _titleController.text,
              content: _contentController.text,
            );
            // Gửi sự kiện Update qua Bloc
            context.read<ArticleBloc>().add(
                UpdateArticleEvent(updatedArticle, widget.article.userId ?? 0));
            Navigator.pop(context); // Đóng dialog
            ToastManager.showToast(
                context: context, message: "Article updated successfully");
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}

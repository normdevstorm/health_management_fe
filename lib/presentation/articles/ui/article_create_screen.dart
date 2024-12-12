import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/utils/functions/image_griphy_picker.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/articles/entities/article_media_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';

class ArticleCreateScreen extends StatefulWidget {
  const ArticleCreateScreen({super.key});

  @override
  State<ArticleCreateScreen> createState() => _ArticleCreateScreenState();
}

class _ArticleCreateScreenState extends State<ArticleCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  ArticleCategory _selectedCategory = ArticleCategory.fitness;
  final List<ArticleMediaEntity> _mediaList = [];
  final List<String> imagePicked = [];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitArticle() {
    if (_formKey.currentState!.validate()) {
      final articleEntity = ArticleEntity(
        title: _titleController.text,
        content: _contentController.text,
        category: _selectedCategory,
        media: _mediaList,
        id: 0,
        userId: 0,
        username: '',
        userAvatar: '',
        upVoteCount: 0,
        commentCount: 0,
        viewCount: 0,
      );

      const userId = 2;
      // context.read<ArticleBloc>().add(
      //       CreateArticleEvent(articleEntity, userId, _mediaList ),
      //     );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state.status == BlocStatus.success) {
          // Nếu tạo thành công, fetch lại data và pop màn hình
          context
              .read<ArticleBloc>()
              .add(const GetAllArticleByUserIdEvent(userId: 2));
          Navigator.pop(context);
        } else if (state.status == BlocStatus.error) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Article'),
          actions: [
            IconButton(
              onPressed: _submitArticle,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Field
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Category Dropdown
                    DropdownButtonFormField<ArticleCategory>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: ArticleCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (ArticleCategory? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Content Field
                    TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Media Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Media',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Add media handling logic here

                                setState(() async {
                                  await _pickImage(context);
                                });
                              },
                              icon: const Icon(Icons.add_photo_alternate),
                              label: const Text('Add Media'),
                            ),
                            if (_mediaList.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _mediaList.length,
                                itemBuilder: (context, index) {
                                  final media = _mediaList[index];
                                  return ListTile(
                                    leading: Image.asset(media.url ?? " "),
                                    title: Text(media.description ?? ''),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          _mediaList.removeAt(index);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Loading indicator
            BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state.status == BlocStatus.loading) {
                  return Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ArticleMediaEntity>?> _pickImage(BuildContext context) async {
    //open and pick image from gallery
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploading...'),
          ),
        );
        showDialog(
          context: context,
          builder: (context) {
            return Image.asset(image.path);
          },
        );

        _mediaList.add(ArticleMediaEntity(url: image.path));
        return _mediaList;
      }
    }
    return null;
  }
}

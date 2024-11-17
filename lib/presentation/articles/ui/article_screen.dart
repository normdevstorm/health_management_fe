import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/article_create_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(GetAllArticleByUserIdEvent(userId: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state.status == BlocStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BlocStatus.error) {
            return Center(child: Text(state.errorMessage.toString()));
          }

          if (state.status == BlocStatus.success) {
            final articles = state.data as List<ArticleEntity>;

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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Create New Article",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }
                return ArticleItem(article: articles[index - 1]);
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

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.title.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Chip(label: Text(article.category.toString().split('.').last)),
              ],
            ),
            const SizedBox(height: 8),
            // Author and Avatar
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(article.userAvatar.toString()),
                ),
                const SizedBox(width: 8),
                Text(article.userName.toString()),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Upvotes: ${article.upVoteCount}"),
                Text("Comments: ${article.commentCount}"),
                Text("Views: ${article.viewCount}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

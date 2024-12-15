import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/article_screen.dart';
import 'package:health_management/presentation/home/bloc/home_bloc.dart';
import 'package:health_management/presentation/home/bloc/home_event.dart';
import 'package:health_management/presentation/home/bloc/home_state.dart';

class ArticleHome extends StatefulWidget {
  const ArticleHome({super.key, required this.title});

  final String title;

  @override
  State<ArticleHome> createState() => _ArticleHomeSate();
}

class _ArticleHomeSate extends State<ArticleHome> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(const GetAllArticleEvent());
    context.read<HomeBloc>().add(const GetAllDoctorTopRateEvent());
  }

  bool _showAllArticles = false;
  final user = SharedPreferenceManager.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  FutureBuilder(
                      future: SharedPreferenceManager.getUser(),
                      builder: (context, snapshot) {
                        final ava = snapshot.data?.avatarUrl;
                        final username = snapshot.data?.firstName;
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      ava ?? "",
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      const Icon(Icons.notifications,
                                          color: Colors.white, size: 30),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          height: 18,
                                          width: 18,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Greeting Text
                              const Text(
                                "Welcome back .....",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                username ?? "Guest",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == BlocStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == BlocStatus.error) {
                  return Center(child: Text(state.errorMessage.toString()));
                }
                final doctors = state.data ?? [];
                if (doctors.isEmpty) {
                  return const Center(
                      child: Text("No top-rated doctors found."));
                }
                if (state.status == BlocStatus.success) {
                  final listDoctor = state.data as List<DoctorEntity>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Top Doctors",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: listDoctor
                              .map(
                                (doctor) => _buildDoctorCard(
                                  doctor.specialization?.name.toUpperCase(),
                                  'https://via.placeholder.com/100',
                                  doctor.rating ?? 0,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Banner Slider
                      const Text(
                        "Promotional Banners",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildBannerSlider(),
                      const SizedBox(height: 15),
                    ],
                  );
                }
                return const Center(child: Text('No doctor found'));
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<ArticleBloc, ArticleState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status &&
                  (current.data.runtimeType == List<ArticleEntity>),
              builder: (context, state) {
                if (state.status == BlocStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == BlocStatus.error) {
                  return Center(child: Text(state.errorMessage.toString()));
                }

                if (state.status == BlocStatus.success) {
                  final articles = state.data as List<ArticleEntity>;
                  // Hiển thị số lượng bài viết dựa trên trạng thái
                  final displayedArticles =
                      _showAllArticles ? articles : articles.take(5).toList();
                  displayedArticles.sort((a, b) =>
                      a.title
                          ?.toUpperCase()
                          .compareTo(b.title?.toUpperCase() ?? "") ??
                      0);

                  return Column(
                    children: [
                      const Text(
                        "Articles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                          future: SharedPreferenceManager.getUser(),
                          builder: (context, snapshot) {
                            final userId = snapshot.data?.id;
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: displayedArticles.length,
                                itemBuilder: (context, index) {
                                  return ArticleItem(
                                      article: displayedArticles[index],
                                      userId: userId);
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      if (articles.length > 5)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showAllArticles = !_showAllArticles;
                            });
                          },
                          child: Text(
                            _showAllArticles ? "Show less" : "Show more",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  );
                }

                return const Center(child: Text('No articles found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDoctorCard(String? title, String imageUrl, double rating) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    child: Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          title ?? " ",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Text(
          "⭐ $rating",
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 10, 10, 10)),
        ),
      ],
    ),
  );
}

Widget _buildBannerSlider() {
  final List<String> bannerUrls = [
    'https://isofhcare-backup.s3-ap-southeast-1.amazonaws.com/images/hinh-anh-benh-vien-da-khoa-vinmec-times-city-ivie_f94ff195_aacc_40e7_981e_99d7d3b8bd94.jpg',
    'https://i.pinimg.com/736x/d0/49/8a/d0498a20f43cc8b6047925c23b27f495.jpg',
    'https://www.vinmec.com/static//uploads/05_12_2018_03_21_27_275433_jpg_081e7b384a.jpg',
  ];

  return SizedBox(
    height: 200,
    child: PageView.builder(
      itemCount: bannerUrls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              bannerUrls[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}

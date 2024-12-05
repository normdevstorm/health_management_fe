import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/multi-languages/locale_keys.dart';
import 'package:health_management/app/utils/regex/regex_manager.dart';
import 'package:health_management/domain/articles/entities/article_entity.dart';
import 'package:health_management/domain/articles/usecases/article_usecase.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/articles/bloc/article_event.dart';
import 'package:health_management/presentation/articles/bloc/article_state.dart';
import 'package:health_management/presentation/articles/ui/article_screen.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/common/chucker_log_button.dart';
import 'package:logger/logger.dart';
import 'app/di/injection.dart';
import 'app/managers/local_storage.dart';
import 'domain/verify_code/usecases/verify_code_usecase.dart';

void main() async {
  //create before runApp method to wrap all the procedures
  WidgetsFlutterBinding.ensureInitialized();
  const String flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
  configureDependencies(FlavorManager.values.firstWhere(
      (element) => element.name == flavor,
      orElse: () => FlavorManager.dev));
  await SharedPreferenceManager.init();
  // if (!kIsWeb) {
  //   await FirebaseApi().initNotificaiton();
  // }

  runApp(
    Material(
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/resources/langs/langs.csv',
        assetLoader: CsvAssetLoader(),
        startLocale: const Locale('vi', 'VN'),
        useFallbackTranslations: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationUsecase: getIt<AuthenticationUsecase>(),
                  verifyCodeUseCase: getIt<VerifyCodeUseCase>()),
            ),
            BlocProvider(
              create: (context) => ArticleBloc(
                articleUsecase: getIt<ArticleUsecase>(),
              ),
            ),
          ],
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: _authenticationListener,
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
}

void _authenticationListener(BuildContext context, AuthenticationState state) {
  BuildContext currentContext =
      globalRootNavigatorKey.currentContext ?? context;

  if (state is AuthenticationInitial) {
    GoRouter.of(currentContext).goNamed(RouteDefine.login);
    return;
  }

  if (state is LoginSuccess) {
    GoRouter.of(currentContext).goNamed(RouteDefine.home);
    return;
  }

  if (state is RegisterSuccess) {
    GoRouter.of(currentContext).goNamed(RouteDefine.login);
    return;
  }

  if (state is VerifyCodeSuccess) {
    context.read<AuthenticationBloc>().add(state.registerSubmitEvent);
    return;
  }

  if (state is AuthenticationError) {
    String errorMessage = state.message;
    //todo: localize this message
    showModalBottomSheet(
      context: context,
      builder: (context) => Text(errorMessage),
    );
    return;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialApp mainApp = MaterialApp.router(
      builder: FToastBuilder(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeManager.darkTheme,
      theme: ThemeManager.lightTheme.copyWith(
          textTheme: ThemeManager.lightTheme.textTheme.copyWith(
            bodyLarge: ThemeManager.lightTheme.textTheme.bodyLarge
                ?.copyWith(fontFamily: 'Poppins'),
            bodyMedium: ThemeManager.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontFamily: 'Poppins'),
            bodySmall: ThemeManager.lightTheme.textTheme.bodySmall
                ?.copyWith(fontFamily: 'Poppins'),
            headlineLarge: ThemeManager.lightTheme.textTheme.displayLarge
                ?.copyWith(fontFamily: 'Poppins'),
            headlineMedium: ThemeManager.lightTheme.textTheme.headlineMedium
                ?.copyWith(fontFamily: 'Poppins'),
            displayLarge: ThemeManager.lightTheme.textTheme.displayLarge
                ?.copyWith(fontFamily: 'Poppins'),
            displayMedium: ThemeManager.lightTheme.textTheme.bodyMedium
                ?.copyWith(fontFamily: 'Poppins'),
            displaySmall: ThemeManager.lightTheme.textTheme.displaySmall
                ?.copyWith(fontFamily: 'Poppins'),
            headlineSmall: ThemeManager.lightTheme.textTheme.headlineSmall
                ?.copyWith(fontFamily: 'Poppins'),
            labelLarge: ThemeManager.lightTheme.textTheme.labelLarge
                ?.copyWith(fontFamily: 'Poppins'),
            labelMedium: ThemeManager.lightTheme.textTheme.labelMedium
                ?.copyWith(fontFamily: 'Poppins'),
            labelSmall: ThemeManager.lightTheme.textTheme.labelSmall
                ?.copyWith(fontFamily: 'Poppins'),
            titleLarge: ThemeManager.lightTheme.textTheme.titleLarge
                ?.copyWith(fontFamily: 'Poppins'),
            titleMedium: ThemeManager.lightTheme.textTheme.titleMedium
                ?.copyWith(fontFamily: 'Poppins'),
            titleSmall: ThemeManager.lightTheme.textTheme.titleSmall
                ?.copyWith(fontFamily: 'Poppins'),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          })),
      routerConfig: AppRouting.shellRouteConfig,
      debugShowCheckedModeBanner: false,
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, child) => Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Stack(children: [
          mainApp,
          Positioned(bottom: 5.sp, right: 5.sp, child: ChuckerLogButton())
        ]),
      ),
      child: mainApp,
    );
  }
}

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
    context.read<ArticleBloc>().add(GetAllArticleEvent());
  }

  bool _showAllArticles = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                      Stack(
                        children: [
                          Icon(Icons.notifications,
                              color: Colors.white, size: 30),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
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
                    "Good Morning.....",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const Text(
                    "LAKSHAY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search......",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Top Doctors" Title
                  const Text(
                    "Top Doctors",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Doctors List
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildDoctorCard(
                            "Neurologist", "https://via.placeholder.com/100"),
                        _buildDoctorCard(
                            "Urologist", "https://via.placeholder.com/100"),
                        _buildDoctorCard(
                            "Pediatrician", "https://via.placeholder.com/100"),
                        _buildDoctorCard(
                            "Radiologist", "https://via.placeholder.com/100"),
                        _buildDoctorCard(
                            "Surgeon", "https://via.placeholder.com/100"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<ArticleBloc, ArticleState>(
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

                  return Column(
                    children: [
                      const Text(
                        "Articles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: displayedArticles.length,
                        itemBuilder: (context, index) {
                          return ArticleItem(article: displayedArticles[index]);
                        },
                      ),
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

Widget _buildBannerSlider() {
  final List<String> bannerUrls = [
    'https://isofhcare-backup.s3-ap-southeast-1.amazonaws.com/images/hinh-anh-benh-vien-da-khoa-vinmec-times-city-ivie_f94ff195_aacc_40e7_981e_99d7d3b8bd94.jpg',
    'https://www.vinmec.com/static//uploads/05_12_2018_03_21_27_275433_jpg_081e7b384a.jpg',
    'https://cdn.hellobacsi.com/wp-content/uploads/2018/07/Benh-vien-da-khoa-medlatec-e1532330580709.jpg?w=828&q=75',
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

Widget _buildDoctorCard(String title, String imageUrl) {
  return Container(
    margin: const EdgeInsets.only(right: 15),
    child: Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({super.key, required this.title, required this.child});

  final String title;
  final StatefulNavigationShell child;

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  late ScrollController _scrollController;
  late ValueNotifier<bool> _navBarVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _navBarVisibleNotifier = ValueNotifier<bool>(true);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_navBarVisibleNotifier.value) {
          _navBarVisibleNotifier.value = false;
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_navBarVisibleNotifier.value) {
          _navBarVisibleNotifier.value = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      barColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.7,
      hideOnScroll: true,
      reverse: true,
      body: (context, controller) {
        return Scaffold(
            body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      if (scrollNotification.scrollDelta! > 0 &&
                          _navBarVisibleNotifier.value) {
                        _navBarVisibleNotifier.value = false;
                      } else if (scrollNotification.scrollDelta! < 0 &&
                          !_navBarVisibleNotifier.value) {
                        _navBarVisibleNotifier.value = true;
                      }
                    }
                    return true;
                  },
                  child: widget.child,
                ),
              ),
            ],
          ),
        ));
      },
      child: _hideBottomNavBar(context)
          ? const SizedBox()
          : ValueListenableBuilder(
              valueListenable: _navBarVisibleNotifier,
              builder: (context, navbarVisible, child) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: navbarVisible ? kBottomNavigationBarHeight * 1.2 : 0.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: BottomNavigationBar(
                      enableFeedback: false,
                      currentIndex: widget.child.currentIndex,
                      selectedItemColor: Colors.blueAccent,
                      unselectedItemColor: Colors.grey,
                      onTap: (value) => widget.child.goBranch(value),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home_rounded), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.inbox_rounded), label: "Chat"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.calendar_month_rounded),
                            label: "Appointment"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person_rounded), label: "Profile"),
                      ]),
                ),
              ),
            ),
    );
  }

  bool _hideBottomNavBar(BuildContext context) => GoRouter.of(context)
      .routeInformationProvider
      .value
      .uri
      .path
      .startsWith(RegexManager.hideBottomNavBarPaths);
}

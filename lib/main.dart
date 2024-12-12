import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/regex/regex_manager.dart';
import 'package:health_management/domain/articles/usecases/article_usecase.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';
import 'package:health_management/firebase_options_chat.dart'
    as firebase_options_chat;
import 'package:health_management/presentation/articles/bloc/article_bloc.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:health_management/presentation/common/chucker_log_button.dart';
// import 'app/config/firebase_api.dart';
import 'app/config/firebase_api.dart';
import 'app/di/injection.dart';
import 'app/managers/toast_manager.dart';
import 'domain/doctor/usecases/doctor_usecase.dart';
import 'domain/verify_code/usecases/verify_code_usecase.dart';
import 'presentation/home/bloc/home_bloc.dart';

void main() async {
  //create before runApp method to wrap all the procedures
  WidgetsFlutterBinding.ensureInitialized();
  const String flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
  configureDependencies(FlavorManager.values.firstWhere(
      (element) => element.name == flavor,
      orElse: () => FlavorManager.dev));
  //TODO: UNCOMMENT THESE 2 LINES TO RUN ON MOBILE DEVICES
  // Initialize the cloud message Firebase project
  await FirebaseMessageService().initNotificaiton();
  // Initialize the chat Firebase project
  await Firebase.initializeApp(
    options: firebase_options_chat.DefaultFirebaseOptions.currentPlatform,
    //TODO: UNCOMMENT THIS LINE TO RUN ON MOBILE DEVICES
    name: 'chatApp',
  );

  runApp(CalendarControllerProvider(
    controller: EventController(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) => EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/resources/langs/langs.csv',
        assetLoader: CsvAssetLoader(),
        startLocale: const Locale('vi', 'VN'),
        useFallbackTranslations: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                  appChatUseCases: getIt<AppChatUseCases>(),
                  authenticationUsecase: getIt<AuthenticationUsecase>(),
                  verifyCodeUseCase: getIt<VerifyCodeUseCase>()),
            ),
            BlocProvider(
              create: (context) => ArticleBloc(
                articleUsecase: getIt<ArticleUsecase>(),
              ),
            ),
                      BlocProvider(
              create: (context) =>
                  HomeBloc(doctorUseCase: getIt<DoctorUseCase>())),
          ],
          child: const BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: _authenticationListener,
            child: MyApp(),
          ),
        ),
      ),
    ),
  ));
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
    ToastManager.showToast(context: currentContext, message: errorMessage);
    if (state.runtimeType == CheckLoginStatusErrorState) {
      GoRouter.of(currentContext).goNamed(RouteDefine.login);
    }
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
          // textTheme: ThemeManager.lightTheme.textTheme.copyWith(
          //   bodyLarge: ThemeManager.lightTheme.textTheme.bodyLarge
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   bodyMedium: ThemeManager.lightTheme.textTheme.bodyMedium
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   bodySmall: ThemeManager.lightTheme.textTheme.bodySmall
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   headlineLarge: ThemeManager.lightTheme.textTheme.displayLarge
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   headlineMedium: ThemeManager.lightTheme.textTheme.headlineMedium
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   displayLarge: ThemeManager.lightTheme.textTheme.displayLarge
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   displayMedium: ThemeManager.lightTheme.textTheme.bodyMedium
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   displaySmall: ThemeManager.lightTheme.textTheme.displaySmall
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   headlineSmall: ThemeManager.lightTheme.textTheme.headlineSmall
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   labelLarge: ThemeManager.lightTheme.textTheme.labelLarge
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   labelMedium: ThemeManager.lightTheme.textTheme.labelMedium
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   labelSmall: ThemeManager.lightTheme.textTheme.labelSmall
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   titleLarge: ThemeManager.lightTheme.textTheme.titleLarge
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   titleMedium: ThemeManager.lightTheme.textTheme.titleMedium
          //       ?.copyWith(fontFamily: 'Poppins'),
          //   titleSmall: ThemeManager.lightTheme.textTheme.titleSmall
          //       ?.copyWith(fontFamily: 'Poppins'),
          // ),
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
          Positioned(bottom: 5.sp, right: 5.sp, child: const ChuckerLogButton())
        ]),
      ),
      child: mainApp,
    );
  }
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
    _navBarVisibleNotifier = AppRouting.navBarVisibleNotifier;
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_navBarVisibleNotifier.value) {
          _navBarVisibleNotifier.value = false;
        }
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward ||
          _scrollController.position.maxScrollExtent > 0) {
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
      showIcon: false,
      barColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.7,
      hideOnScroll: true,
      body: (context, controller) {
        return Scaffold(
            body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.metrics.axis == Axis.vertical) {
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

  bool _hideBottomNavBar(BuildContext context) {
    final bool hideNavBar = GoRouter.of(context)
            .state
            ?.matchedLocation
            .startsWith(RegexManager.hideBottomNavBarPaths) ??
        false;
    if (!hideNavBar) {
      _navBarVisibleNotifier.value = true;
    }
    return hideNavBar;
  }
}

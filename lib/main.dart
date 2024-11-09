import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
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
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    // context.read<AuthenticationBloc>().add(LogOutEvent());
    // AppointmentRecordEntity response = await appointmentUseCase
    //     .createAppointmentRecord(AppointmentRecordEntity(
    //         note: "note",
    //         status: AppointmentStatus.pending,
    //         scheduledAt: DateTime.now(),
    //         appointmentType: AppointmentType.inPerson,
    //         doctor: const DoctorEntity(id: 3),
    //         healthProvider: HealthProviderEntity(id: 1),
    //         user: const UserEntity(id: 6)));
    UserEntity doctors = await getIt<UserUseCase>().getUserSummary(2);
    getIt<Logger>().i(doctors);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.counterDescription.tr(),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'null',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
    _navBarVisibleNotifier = ValueNotifier<bool>(true);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (_navBarVisibleNotifier.value) {
    //       _navBarVisibleNotifier.value = false;
    //     }
    //   } else if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     if (!_navBarVisibleNotifier.value) {
    //       _navBarVisibleNotifier.value = true;
    //     }
    //   }
    // });
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
      child: ValueListenableBuilder(
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
}

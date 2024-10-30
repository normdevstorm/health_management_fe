import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/firebase_api.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/app/utils/multi-languages/locale_keys.dart';
import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
import 'package:health_management/domain/doctor/entities/doctor_entity.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:health_management/presentation/auth/bloc/authentication_bloc.dart';
import 'package:logger/logger.dart';

import 'app/di/injection.dart';
import 'app/managers/local_storage.dart';
import 'domain/appointment/repositories/appointment_repository.dart';

void main() async {
  //create before runApp method to wrap all the procedures
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SharedPreferenceManager.init();
  if (!kIsWeb) {
    await FirebaseApi().initNotificaiton();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      startLocale: const Locale('vi', 'VN'),
      useFallbackTranslations: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationUsecase: getIt<AuthenticationUsecase>()),
          ),
        ],
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // TODO: implement listener in a separate mehthod/function
            _authenticationListener(context, state);
          },
          child: const MyApp(),
        ),
      ),
    ),
  );
}

void _authenticationListener(BuildContext context, AuthenticationState state) {
  BuildContext currentContext =
      globalRootNavigatorKey.currentContext ?? context;
  //todo: Redirect to profile page after register sucess
  if (state is LoginSuccess || state is RegisterSuccess) {
    GoRouter.of(currentContext).goNamed(RouteDefine.home);
  }

  if (state is LoginError || state is RegisterError) {
    String errorMessage = state is LoginError
        ? state.message
        : state is RegisterError
            ? state.message
            //todo: localize this message
            : "There's something wrong!";
    showModalBottomSheet(
      context: context,
      builder: (context) => Text(errorMessage),
    );
  }

  if (state is AuthenticationInitial) {
    GoRouter.of(currentContext).goNamed(RouteDefine.login);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialApp mainApp = MaterialApp.router(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      theme: ThemeManager.lightTheme.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder()
      })),
      routerConfig: AppRouting.shellRouteConfig(),
      debugShowCheckedModeBanner: false,
    );
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (context, child) => mainApp);
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
    AuthenticationUsecase authenticationUsecase =
        getIt<AuthenticationUsecase>();
    AppointmentUseCase appointmentUseCase = getIt.get<AppointmentUseCase>();
    Logger logger = getIt.get<Logger>();
    AppointmentRecordEntity response = await appointmentUseCase
        .updateAppointmentRecord(const AppointmentRecordEntity());
    // await authenticationUsecase.getAppointment(3);
    // context.read<LoginBloc>().add(const RegisterEvent(
    //     "namuser1gmail.com", "12345678", "normdevstorm2021", Role.doctor));
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
              Expanded(child: widget.child),
            ],
          ),
        ));
      },
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
    );
  }
}

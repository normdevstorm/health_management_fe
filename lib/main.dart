import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/firebase_api.dart';
import 'package:health_management/app/route/app_routing.dart';
import 'package:health_management/app/utils/multi-languages/locale_keys.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/domain/login/entities/login_entity.dart';
import 'package:health_management/domain/login/usecases/authentication_usecase.dart';

import 'app/di/injection.dart';

void main() async {
  //create before runApp method to wrap all the procedures
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  if (!kIsWeb) {
    await FirebaseApi().initNotificaiton();
  }

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/resources/langs/langs.csv',
    assetLoader: CsvAssetLoader(),
    startLocale: const Locale('en', 'US'),
    useFallbackTranslations: true,
    child: const MyApp(),
  ));
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
      theme: ThemeManager.lightTheme,
      routerConfig: AppRouting.shellRouteConfig(),
    );
    return mainApp;
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

  Future<LoginEntity?> _fetchData() async {
    final AuthenticationUsecase authenticationUsecase =
        getIt.get<AuthenticationUsecase>();
    final LoginEntity? loginEntity = await authenticationUsecase.login(
        const LoginRequest(email: "namuser5@gmail.com", password: "12345678"));
    if (loginEntity != null) {
      // print(loginEntity.accessToken);
      return loginEntity;
    }
    return null;
  }

  void _incrementCounter() {
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
            FutureBuilder<LoginEntity?>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    snapshot.data?.accessToken ?? 'null',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
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

class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key, required this.title, required this.child});

  final String title;
  final StatefulNavigationShell child;
  // late  int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomBar(
      barColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.7,
      hideOnScroll: true,
      reverse: true,
      body: (context, controller) => Scaffold(body: child),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: BottomNavigationBar(
            enableFeedback: false,
            currentIndex: child.currentIndex,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            onTap: (value) => child.goBranch(value),
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

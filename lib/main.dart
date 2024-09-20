import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/firebase_api.dart';
import 'package:health_management/app/utils/multi-languages/locale_keys.dart';
import 'package:health_management/data/auth/api/authentication_api.dart';
import 'package:health_management/data/auth/models/request/login_request_model.dart';
import 'package:health_management/data/auth/models/response/login_response_model.dart';
import 'package:health_management/data/common/api_response_model.dart';
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
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      theme: ThemeManager.lightTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  Future<LoginEntity?> _fetchData() async {
    final AuthenticationUsecase authenticationUsecase =
        getIt.get<AuthenticationUsecase>();
    final LoginEntity? loginEntity = await authenticationUsecase.login(
        const LoginRequest(email: "namuser5@gmail.com", password: "12345678"));
    if (loginEntity != null) {
      print(loginEntity.accessToken);
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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

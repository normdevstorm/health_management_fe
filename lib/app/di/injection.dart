// part of '../app.dart';
import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:health_management/app/config/refresh_token_interceptor.dart';
import 'package:health_management/app/config/request_interceptor.dart';
import 'package:health_management/data/appointment/api/appointment_api.dart';
import 'package:health_management/data/appointment/repositories/appointment_repository_impl.dart';
import 'package:health_management/data/auth/api/authentication_api.dart';
import 'package:health_management/data/auth/repositories/authentication_repository_impl.dart';
import 'package:health_management/data/health_provider/api/health_provider_api.dart';
import 'package:health_management/data/health_provider/repositories/health_provider_repository_impl.dart';
import 'package:health_management/data/verify_code/api/verify_code_api.dart';
import 'package:health_management/domain/appointment/repositories/appointment_repository.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/health_provider/repositories/health_provider_repository.dart';
import 'package:health_management/domain/user/repositories/user_repository.dart';
import 'package:health_management/domain/verify_code/usecases/verify_code_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../data/user/api/user_api.dart';
import '../../data/user/repositories/user_repository_impl.dart';
import '../../data/verify_code/repositories/verify_code_repository_impl.dart';
import '../../domain/auth/repositories/authentication_repository.dart';
import '../../domain/health_provider/usecases/health_provider_usecase.dart';
import '../../domain/user/usecases/user_usecase.dart';
import '../../domain/verify_code/repositories/verify_code_repository.dart';
import '../app.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  // TODO: refine generated dir later on
  // generateForDir:
)
void configureDependencies(FlavorManager flavor) {
  getIt.init();
  setUpNetworkComponent(flavor);
  setUpAppComponent();
}

void setUpNetworkComponent(FlavorManager flavor) {
  Dio dio = Dio(BaseOptions(
    baseUrl: ConfigManager.getInstance(flavorName: flavor.name).apiBaseUrl,
    contentType: Headers.jsonContentType,
    headers: {
      HttpHeaders.accessControlAllowOriginHeader: "*",
      HttpHeaders.accessControlAllowMethodsHeader:
          "GET, POST, PUT, DELETE, OPTIONS",
    },
  ));
  dio.interceptors.addAll([
    PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        request: true),
    ChuckerDioInterceptor(),
    RequestInterceptor(),
    RefreshTokenInterceptor(),
  ]);
  getIt.registerLazySingleton(() => AuthenticationApi(dio));
  getIt.registerLazySingleton(() => AppointmentApi(dio));
  getIt.registerLazySingleton(() => UserApi(dio));
  getIt.registerLazySingleton(
      () => VerifyCodeApi(dio, baseUrl: 'https://api.duynguyendev.xyz/api/v1'));
  getIt.registerLazySingleton(() => HealthProviderApi(dio));
}

void setUpAppComponent() {
  //Logger
  getIt.registerSingleton<Logger>(Logger(
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  ));
  //Inject repositories
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<VerifyCodeRepository>(
      () => VerifyCodeRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<HealthProviderRepository>(
      () => HealthProviderRepositoryImpl(getIt(), getIt()));

  //Inject Usecases
  getIt.registerLazySingleton(() => AppointmentUseCase(getIt()));
  getIt.registerLazySingleton(() => AuthenticationUsecase(getIt()));
  getIt.registerLazySingleton<VerifyCodeUseCase>(
      () => VerifyCodeUseCase(getIt()));
  getIt.registerLazySingleton(() => UserUseCase(getIt()));
  getIt.registerLazySingleton(() => HealthProviderUseCase(getIt()));
}

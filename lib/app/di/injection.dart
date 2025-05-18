// part of '../app.dart';
import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:health_management/app/config/firebase_api.dart';
import 'package:health_management/app/config/refresh_token_interceptor.dart';
import 'package:health_management/app/config/request_interceptor.dart';
import 'package:health_management/app/utils/local_notification/notification_service.dart';
import 'package:health_management/data/appointment/api/appointment_api.dart';
import 'package:health_management/data/appointment/repositories/appointment_repository_impl.dart';
import 'package:health_management/data/articles/api/articles_api.dart';
import 'package:health_management/data/articles/repositories/article_repository_impl.dart';
import 'package:health_management/data/auth/api/authentication_api.dart';
import 'package:health_management/data/auth/repositories/authentication_repository_impl.dart';
import 'package:health_management/data/chat/repositories/call_repository.dart';
import 'package:health_management/data/chat/repositories/chat_group_repository.dart';
import 'package:health_management/data/chat/repositories/contacts_repository.dart';
import 'package:health_management/data/chat/repositories/status_repository.dart';
import 'package:health_management/data/chat/repositories/user_repository.dart';
import 'package:health_management/data/doctor_schedule/api/doctor_schedule_api.dart';
import 'package:health_management/data/doctor_schedule/repositories/doctor_schedule_repository_impl.dart';
import 'package:health_management/data/doctor/api/doctor_api.dart';
import 'package:health_management/data/doctor/repositories/doctor_repository_impl.dart';
import 'package:health_management/data/health_provider/api/health_provider_api.dart';
import 'package:health_management/data/health_provider/repositories/health_provider_repository_impl.dart';
import 'package:health_management/data/payment/api/zalopay_api.dart';
import 'package:health_management/data/prescription/repositories/prescription_repository_impl.dart';
import 'package:health_management/data/verify_code/api/verify_code_api.dart';
import 'package:health_management/domain/appointment/repositories/appointment_repository.dart';
import 'package:health_management/domain/appointment/usecases/appointment_usecase.dart';
import 'package:health_management/domain/articles/repositories/article_repository.dart';
import 'package:health_management/domain/articles/usecases/article_usecase.dart';
import 'package:health_management/domain/auth/usecases/authentication_usecase.dart';
import 'package:health_management/domain/chat/repositories/auth_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/call_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/chat_group_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/chat_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/contacts_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/message_contact_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/status_repository_impl.dart';
import 'package:health_management/domain/chat/repositories/user_repository_impl.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';
import 'package:health_management/domain/chat/usecases/auth/auth_cases.dart';
import 'package:health_management/domain/chat/usecases/call/call_usecase.dart';
import 'package:health_management/domain/chat/usecases/chat/chat_cases.dart';
import 'package:health_management/domain/chat/usecases/chat_contacts/message_contact_cases.dart';
import 'package:health_management/domain/chat/usecases/chat_group/chat_group_usecase.dart';
import 'package:health_management/domain/chat/usecases/contacts/contacts_use_case.dart';
import 'package:health_management/domain/chat/usecases/status/status_cases.dart';
import 'package:health_management/domain/chat/usecases/user/user_cases.dart';
import 'package:health_management/domain/doctor_schedule/usecases/doctor_schedule_usecase.dart';
import 'package:health_management/domain/doctor/usecases/doctor_usecase.dart';
import 'package:health_management/domain/doctor/repositories/doctor_repository.dart';
import 'package:health_management/domain/health_provider/repositories/health_provider_repository.dart';
import 'package:health_management/domain/user/repositories/user_repository.dart';
import 'package:health_management/domain/verify_code/usecases/verify_code_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../data/chat/datasources/auth/auth_local.dart';
import '../../data/chat/datasources/auth/auth_service.dart';
import '../../data/chat/datasources/call/call_remote_data_source.dart';
import '../../data/chat/datasources/chat_contacts/chat_contacts.dart';
import '../../data/chat/datasources/chats/chat_data_source.dart';
import '../../data/chat/datasources/contacts/contacts_data_source.dart';
import '../../data/chat/datasources/groups/groups_remote_data_source.dart';
import '../../data/chat/datasources/status/status_data_source.dart';
import '../../data/chat/datasources/user/user_data_source.dart';
import '../../data/chat/repositories/auth_repository.dart';
import '../../data/chat/repositories/chat_contact_repository.dart';
import '../../data/chat/repositories/chat_repository.dart';
import '../../data/prescription/api/medication_api.dart';
import '../../data/prescription/api/prescription_api.dart';
import '../../data/user/api/user_api.dart';
import '../../data/user/repositories/user_repository_impl.dart';
import '../../data/verify_code/repositories/verify_code_repository_impl.dart';
import '../../domain/auth/repositories/authentication_repository.dart';
import '../../domain/doctor_schedule/repositories/doctor_schedule_repository.dart';
import '../../domain/health_provider/usecases/health_provider_usecase.dart';
import '../../domain/prescription/repositories/prescription_repository.dart';
import '../../domain/prescription/usecases/prescription_usecase.dart';
import '../../domain/user/usecases/user_usecase.dart';
import '../../domain/verify_code/repositories/verify_code_repository.dart';
import '../app.dart';
import '../managers/local_storage.dart';
import 'injection.config.dart';
import 'package:timezone/data/latest.dart' as tz;

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  // TODO: refine generated dir later on
  // generateForDir:
)
Future<void> configureDependencies(FlavorManager flavor) async {
  getIt.init();
  setUpNetworkComponent(flavor);
  await setUpAppUtilitis(flavor);
  setUpAppComponent(flavor);
}

Future<void> setUpAppUtilitis(FlavorManager flavor) async {
  //SharedPreference
  await SharedPreferenceManager.init();

  //Logger
  getIt.registerSingleton<Logger>(Logger(
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  ));

  // Initialize Firebase project
  await Firebase.initializeApp(
      options:
          ConfigManager.getInstance(flavorName: flavor.name).firebaseOptions);

  // Initialize Firebase Messaging
  await FirebaseMessageService().initNotificaiton();

  // Initialize Notification Service
  tz.initializeTimeZones();
  await NotificationService.initializeNotification();
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
    RefreshTokenInterceptor(),
    RequestInterceptor(),
  ]);
  getIt.registerSingleton<Dio>(dio);
  getIt.registerLazySingleton(() => AuthenticationApi(dio));
  getIt.registerLazySingleton(() => AppointmentApi(dio));
  getIt.registerLazySingleton(() => UserApi(dio));
  getIt.registerLazySingleton(() => PrescriptionApi(dio,
      baseUrl: 'https://api.duynguyendev.xyz/api/v1/openai/chat/'));
  getIt.registerLazySingleton(() => MedicationApi(dio));
  getIt.registerLazySingleton(
      () => VerifyCodeApi(dio, baseUrl: 'https://api.duynguyendev.xyz/api/v1'));
  getIt.registerLazySingleton(() => HealthProviderApi(dio));

  getIt.registerLazySingleton(() => ArticlesApi(dio));
  getIt.registerLazySingleton(() => DoctorScheduleApi(dio));
  getIt.registerLazySingleton(() => DoctorApi(dio));

  getIt.registerLazySingleton(
      () => ZalopayApi(dio, baseUrl: "https://sb-openapi.zalopay.vn/v2"));
}

setUpAppComponent(FlavorManager flavor) {
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
  getIt.registerLazySingleton<PrescriptionRepository>(
      () => PrescriptionRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<DoctorScheduleRepository>(
      () => DoctorScheduleRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(getIt(), getIt()));

  //Inject Usecases
  getIt.registerLazySingleton(() => AppointmentUseCase(getIt()));
  getIt.registerLazySingleton(() => AuthenticationUsecase(getIt()));
  getIt.registerLazySingleton<VerifyCodeUseCase>(
      () => VerifyCodeUseCase(getIt()));
  getIt.registerLazySingleton(() => UserUseCase(getIt()));
  getIt.registerLazySingleton(() => HealthProviderUseCase(getIt()));
  getIt.registerLazySingleton(() => ArticleUsecase(getIt()));
  getIt.registerLazySingleton(() => PrescriptionUseCase(getIt()));
  getIt.registerLazySingleton(() => DoctorScheduleUseCase(getIt()));
  getIt.registerLazySingleton(() => DoctorUseCase(getIt()));

  // Inject chat dpendencies
  //DataSources
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  getIt.registerLazySingleton<StatusRemoteDataSource>(
      () => StatusRemoteDataSourceImpl());
  getIt.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl());
  getIt.registerLazySingleton<ChatContactsRemoteDataSource>(
      () => MessageContactsRemoteDataSourceImpl());
  getIt.registerLazySingleton<ContactsRemoteDataSource>(
      () => ContactsRemoteDataSourceImpl());
  getIt.registerLazySingleton<GroupsRemoteDataSource>(
      () => GroupsRemoteDataSourceImpl());
  getIt.registerLazySingleton<CallRemoteDataSource>(
      () => CallRemoteDataSourceImpl());

  //Repository
  getIt.registerLazySingleton<UserChatRepository>(
      () => UserChatRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ChatContactRepository>(
      () => MessageContactRepositoryImpl(getIt()));
  getIt.registerLazySingleton<StatusRepository>(
      () => StatusRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<ChatGroupRepository>(
      () => ChatGroupRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<CallRepository>(() => CallRepositoryImpl(getIt()));

  //UseCases
  getIt.registerLazySingleton<UserChatUseCase>(() => UserChatUseCase(getIt()));
  getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));
  getIt.registerLazySingleton<ChatUseCase>(() => ChatUseCase(getIt()));
  getIt.registerLazySingleton<ChatContactsUseCase>(
      () => ChatContactsUseCase(getIt()));
  getIt.registerLazySingleton<StatusUseCases>(() => StatusUseCases(getIt()));
  getIt.registerLazySingleton<ContactsUseCase>(() => ContactsUseCase(getIt()));
  getIt
      .registerLazySingleton<ChatGroupUseCase>(() => ChatGroupUseCase(getIt()));
  getIt.registerLazySingleton<CallUseCase>(() => CallUseCase(getIt()));
  getIt.registerLazySingleton<AppChatUseCases>(() => AppChatUseCases(
        auth: getIt(),
        user: getIt(),
        chat: getIt(),
        status: getIt(),
        chatContacts: getIt(),
        contacts: getIt(),
        chatGroup: getIt(),
        call: getIt(),
      ));
}

import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/appointment/repositories/appointment_repository.dart';
import 'package:logger/logger.dart';

void main() async {
  // configureDependencies();
  AppointmentRepository repository = getIt.get<AppointmentRepository>();
  Logger logger = getIt.get<Logger>();
  List? response = await repository.getAllAppointmentRecords();
  logger.i(response);
  // const LoginRequest(
  //   email: "namuser5@gmail.com",
  //   password: "12345678",
  //   fcmToken:
  //       "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q"));
  // print(response.toString());
}

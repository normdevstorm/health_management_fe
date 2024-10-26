
  import 'package:health_management/domain/appointment/entities/appointment_record_entity.dart';

abstract class AppointmentRepository {
    Future<List<AppointmentRecordEntity>> getAllAppointmentRecords();
}


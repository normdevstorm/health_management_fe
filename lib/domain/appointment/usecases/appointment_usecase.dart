import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../../../app/utils/file_downloader.dart';
import '../entities/appointment_record_entity.dart';
import '../repositories/appointment_repository.dart';

class AppointmentUseCase {
  final AppointmentRepository _repository;

  AppointmentUseCase(this._repository);

  Future<List<AppointmentRecordEntity>> getAllAppointmentRecords() async {
    return _repository.getAllAppointmentRecords();
  }

  Future<AppointmentRecordEntity> createAppointmentRecord(
      AppointmentRecordEntity appointment) async {
    return _repository.createAppointmentRecord(appointment);
  }

  Future<AppointmentRecordEntity> updateAppointmentRecord(
      AppointmentRecordEntity appointment) async {
    return _repository.updateAppointmentRecord(appointment);
  }

  Future<String> deleteAppointmentRecord(int appointmentId) async {
    return _repository.deleteAppointmentRecord(appointmentId);
  }

  Future<List<AppointmentRecordEntity>> getAppointmentRecordByUserId(
      {required int userId}) async {
    return _repository.getAppointmentRecordByUserId(userId);
  }

  Future<AppointmentRecordEntity> getAppointmentRecordById(
      {required int appointmentId}) async {
    return _repository.getAppointmentRecordById(appointmentId);
  }

  Future<List<AppointmentRecordEntity>> getAppointmentRecordByDoctorId(
      {required int doctorId}) async {
    return _repository.getAppointmentRecordByDoctorId(doctorId);
  }

  Future<String> cancelAppointmentRecord(
      {required int userId, required int appointmentId}) async {
    return _repository.cancelAppointmentRecord(userId, appointmentId);
  }

  Future<String?> exportAppointmentPDF(int id, String language) async {
    final response = await _repository.exportAppointmentPDF(id, language);
    if (response.isEmpty) {
      throw Exception('Failed to export appointment PDF');
    }
    Uint8List bytes = Uint8List.fromList(response);

    if (Platform.isAndroid) {
      return await FileDownloader.saveFileWithSAF(bytes, 'appointment_$id.pdf');
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/appointment_$id.pdf';
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      return filePath;
    }
  }
}

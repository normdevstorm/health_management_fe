import 'dart:io';
import 'dart:typed_data';
import 'package:health_management/app/di/injection.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/utils/file_downloader.dart';
import '../entities/doctor_schedule_entity.dart';
import '../repositories/doctor_schedule_repository.dart';

class DoctorScheduleUseCase {
  final DoctorScheduleRepository _repository;

  DoctorScheduleUseCase(this._repository);

  Future<List<DoctorScheduleEntity>> getDoctorSchedule(
      int doctorId, int patientId) {
    return _repository.getDoctorSchedule(doctorId, patientId);
  }

  Future<String?> exportDoctorSchedules(
      int doctorId, String startDate, String endDate, String fileName) async {
    try {
      // Make the API call to get the file data
      final response =
          await _repository.exportDoctorSchedules(doctorId, startDate, endDate);

      // Convert List<int> to Uint8List
      final Uint8List bytes = Uint8List.fromList(response);

      // Use SAF for Android
      if (Platform.isAndroid) {
        return await FileDownloader.saveFileWithSAF(bytes, fileName);
      }
      // For iOS or other platforms
      else {
        Directory directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(bytes);
        return filePath;
      }
    } catch (e) {
      getIt<Logger>().e('Error exporting schedules: $e');
      return null;
    }
  }
}

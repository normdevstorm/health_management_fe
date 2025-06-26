import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:logger/logger.dart';

import '../di/injection.dart';

class FileDownloader {
  static Future<String?> saveFileWithSAF(
      Uint8List bytes, String fileName) async {
    try {
      if (Platform.isAndroid) {
        final params = SaveFileDialogParams(
          data: bytes,
          fileName: fileName,
          mimeTypesFilter: [
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'application/pdf',
          ],
        );
        final filePath = await FlutterFileDialog.saveFile(params: params);
        if (filePath != null) {
          getIt<Logger>().i('File saved at: $filePath');
        }
        return filePath;
      }
      return null;
    } catch (e) {
      getIt<Logger>().e('Error saving file: $e');
      return null;
    }
  }
}

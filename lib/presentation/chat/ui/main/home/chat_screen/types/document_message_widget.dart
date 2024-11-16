import 'package:health_management/app/utils/constants/app_color.dart';
import 'package:health_management/app/utils/functions/download.dart';
import 'package:health_management/domain/chat/models/message_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/types/time_sent_message_widget.dart';

class DocumentMessageWidget extends StatelessWidget {
  final Message messageData;
  final bool isSender;
  const DocumentMessageWidget(
      {super.key, required this.messageData, required this.isSender});

  @override
  Widget build(BuildContext context) {
    String fileName = messageData.content.split('=').last;
    String shortFileName =
        fileName.length > 15 ? "${fileName.substring(0, 15)}..." : fileName;
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading:
                  const Icon(Icons.insert_drive_file), // Biểu tượng tài liệu
              title: Text(shortFileName), // Tên tài liệu
              trailing: const Icon(Icons.file_download), // Biểu tượng tải xuống
              onTap: () {
                // Xử lý khi người dùng nhấn vào tài liệu
                // Ví dụ: Mở tài liệu, tải xuống, hoặc hiển thị thông báo
                _handleDocumentTap(messageData.content, context);
              },
            ),
          ),
          TimeSentMessageWidget(
            isSender: isSender,
            messageData: messageData,
            colors: isSender ? AppColor.primaryColor : AppColor.grey,
          ),
        ]);
  }

  Future<void> _handleDocumentTap(
      String documentUrl, BuildContext context) async {
    //download document
    String? path = await pickSavePath(context);
    if (path != null) {
      await downloadFile(documentUrl, path);
    }
  }

  /*Future<String?> getSavePath() async {
    try {
      // Lấy thư mục lưu trữ tạm thời trên thiết bị
      Directory? appDocDir = await getTemporaryDirectory();
      if (appDocDir != null) {
        return appDocDir.path;
      } else {
        throw Exception('Không thể truy cập thư mục lưu trữ tạm thời.');
      }
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
      return null;
    }
  }*/
  Future<String?> pickSavePath(BuildContext context) async {
    try {
      // Hiển thị picker để người dùng chọn đường dẫn
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        return '$result/${messageData.content.split('=').last}';
      } else {
        throw Exception('Không có đường dẫn được chọn.');
      }
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
      return null;
    }
  }
}

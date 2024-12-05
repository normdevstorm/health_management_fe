import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> downloadFile(String url, String savePath) async {
  try {
    // Tạo yêu cầu HTTP GET để tải tệp từ URL
    final response = await http.get(Uri.parse(url));

    // Kiểm tra mã trạng thái của phản hồi
    if (response.statusCode == 200) {
      // Mở một luồng đến vị trí lưu trữ trên thiết bị
      final file = File(savePath);
      // Ghi dữ liệu từ phản hồi HTTP vào tệp trên thiết bị
      await file.writeAsBytes(response.bodyBytes);
      print('File đã được tải xuống và lưu tại: $savePath');
    } else {
      throw Exception('Lỗi khi tải xuống tệp: ${response.statusCode}');
    }
  } catch (e) {
    print('Đã xảy ra lỗi: $e');
  }
}

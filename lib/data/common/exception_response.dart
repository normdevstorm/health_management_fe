import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class ExceptionResponse {
  final DateTime timestamp;
  final String message;
  final String details;
  final String status;

  ExceptionResponse({
    required this.timestamp,
    required this.message,
    required this.details,
    required this.status,
  });

  factory ExceptionResponse.fromJson(Map<String, dynamic> json) {
    return ExceptionResponse(
      timestamp: DateTime.parse(json['timestamp']),
      message: json['message'],
      details: json['details'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'message': message,
      'details': details,
      'status': status,
    };
  }
}
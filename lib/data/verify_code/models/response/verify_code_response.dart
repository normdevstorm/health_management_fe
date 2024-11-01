import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_code_response.freezed.dart';
part 'verify_code_response.g.dart';

@freezed
class VerifyCodeResponse with _$VerifyCodeResponse {
  factory VerifyCodeResponse({required String message}) = _VerifyCodeResponse;

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);
}

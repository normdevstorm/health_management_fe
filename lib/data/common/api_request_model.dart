
import 'package:json_annotation/json_annotation.dart';
part 'api_request_model.g.dart';

@JsonSerializable(explicitToJson: true,genericArgumentFactories: true)
class ApiRequest<T> {
  final T? data;
  ApiRequest({this.data});

  factory ApiRequest.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$ApiRequestFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ApiRequestToJson(this, toJsonT);
}

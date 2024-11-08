import 'package:health_management/data/address/models/request/address_request.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/health_provider/entities/health_provider_entity.dart';
part 'health_provider_request.g.dart';

@JsonSerializable()
class HealthProviderRequest {
  final int? id;
  final String? name;
  final String? description;
  final AddressRequest? address;
  //todo: check if this property is needed later on
  HealthProviderRequest(
      {this.id, this.name, this.address, this.description});

  factory HealthProviderRequest.fromEntity(HealthProviderEntity entity) => HealthProviderRequest(
      id: entity.id, name: entity.name, description: entity.description, address: AddressRequest.fromEntity(entity.address));

  factory HealthProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$HealthProviderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HealthProviderRequestToJson(this);
}
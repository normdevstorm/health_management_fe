import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/address/entities/address_entity.dart';
part 'health_provider_response.g.dart';

@JsonSerializable()
class HealthProviderResponse {
  final int id;
  final String? name;
  final String? description;
  final AddressEntity? address;
  //todo: check if this property is needed later on
  // final List<Doctor> doctors;
  HealthProviderResponse(
      {required this.id, this.name, this.address, this.description});

  HealthProviderEntity toEntity() => HealthProviderEntity(
      id: id, name: name, description: description, address: address);

  factory HealthProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthProviderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HealthProviderResponseToJson(this);
}

import 'package:health_management/data/address/models/response/address_response.dart';
import 'package:health_management/data/doctor/models/response/doctor_summary_response.dart';
import 'package:health_management/domain/health_provider/entities/health_provider_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health_provider_response.g.dart';

@JsonSerializable()
class HealthProviderResponse {
  final int? id;
  final String? name;
  final String? description;
  final AddressResponse? address;
  //todo: check if this property is needed later on
  final List<DoctorSummaryResponse>? doctors;
  HealthProviderResponse(
      {this.id, this.name, this.address, this.description, this.doctors});

  HealthProviderEntity toEntity() => HealthProviderEntity(
      id: id, name: name, description: description, address: address?.toEntity(), doctors: doctors?.map((e) => e.toEntity()).toList());

  factory HealthProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthProviderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HealthProviderResponseToJson(this);
}

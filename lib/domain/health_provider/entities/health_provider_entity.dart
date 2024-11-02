import 'package:json_annotation/json_annotation.dart';
import '../../address/entities/address_entity.dart';
part 'health_provider_entity.g.dart';

@JsonSerializable()
class HealthProviderEntity {
  final int id;
  final String? name;
  final String? description;
  final AddressEntity? address;

  HealthProviderEntity({
    required this.id,
    this.name,
    this.description,
    this.address,
  });

  HealthProviderEntity copyWith({
    int? id,
    String? name,
    String? description,
    AddressEntity? address,
  }) {
    return HealthProviderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
    );
  }

  factory HealthProviderEntity.fromJson(Map<String, dynamic> json) => _$HealthProviderEntityFromJson(json);
  Map<String, dynamic> toJson() => _$HealthProviderEntityToJson(this);
}

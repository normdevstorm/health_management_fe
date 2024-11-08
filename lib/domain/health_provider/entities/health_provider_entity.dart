import 'package:health_management/domain/user/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../address/entities/address_entity.dart';
part 'health_provider_entity.g.dart';

@JsonSerializable()
class HealthProviderEntity {
  final int? id;
  final String? name;
  final String? description;
  final AddressEntity? address;
  final List<UserEntity>? doctors;

  HealthProviderEntity({
    this.id,
    this.name,
    this.description,
    this.address,
    this.doctors,
  });

  HealthProviderEntity copyWith({
    int? id,
    String? name,
    String? description,
    AddressEntity? address,
    List<UserEntity>? doctors,
  }) {
    return HealthProviderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      doctors: doctors ?? this.doctors,
    );
  }

  factory HealthProviderEntity.requestOrUpdate(
    int? id,
    String? name,
    String? description,
    AddressEntity? address,
  ) =>
      HealthProviderEntity(
        id: id,
        name: name,
        description: description,
        address: address,
      );
  factory HealthProviderEntity.fromJson(Map<String, dynamic> json) =>
      _$HealthProviderEntityFromJson(json);
  Map<String, dynamic> toJson() => _$HealthProviderEntityToJson(this);
}

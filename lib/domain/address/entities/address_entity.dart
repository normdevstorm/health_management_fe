import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';

@JsonSerializable()
class AddressEntity {
  final int? id;
  final int? isDefault;
  final String? unitNumber;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? streetNumber;
  final String? city;
  final String? region;
  final String? postalCode;

  AddressEntity({
    this.id,
    this.isDefault,
    this.unitNumber,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.streetNumber,
    this.city,
    this.region,
    this.postalCode,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);

  AddressEntity copyWith({
    int? id,
    int? isDefault,
    String? unitNumber,
    String? addressLine1,
    String? addressLine2,
    String? country,
    String? streetNumber,
    String? city,
    String? region,
    String? postalCode,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
      unitNumber: unitNumber ?? this.unitNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      country: country ?? this.country,
      streetNumber: streetNumber ?? this.streetNumber,
      city: city ?? this.city,
      region: region ?? this.region,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}

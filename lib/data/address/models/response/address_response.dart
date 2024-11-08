import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/address/entities/address_entity.dart';
part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
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

  AddressResponse({
    required this.id,
    required this.isDefault,
    this.unitNumber,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.streetNumber,
    this.city,
    this.region,
    this.postalCode,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      isDefault: isDefault,
      unitNumber: unitNumber,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      country: country,
      streetNumber: streetNumber,
      city: city,
      region: region,
      postalCode: postalCode,
    );
  }

  factory AddressResponse.fromEntity(AddressEntity entity) {
    return AddressResponse(
      id: entity.id,
      isDefault: entity.isDefault,
      unitNumber: entity.unitNumber,
      addressLine1: entity.addressLine1,
      addressLine2: entity.addressLine2,
      country: entity.country,
      streetNumber: entity.streetNumber,
      city: entity.city,
      region: entity.region,
      postalCode: entity.postalCode,
    );
  }
}
import 'package:json_annotation/json_annotation.dart';
part 'address_entity.g.dart';
@JsonSerializable()
class AddressEntity {
  final int id;
  final bool isDefault;
  final String? unitNumber;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? streetNumber;
  final String? city;
  final String? region;
  final String? postalCode;

  AddressEntity(
      {
        required this.id,
        required this.isDefault,
        this.unitNumber,
        this.addressLine1,
        this.addressLine2,
        this.country,
        this.streetNumber,
        this.city,
        this.region,
        this.postalCode
      });


    factory AddressEntity.fromJson(Map<String, dynamic> json) => _$AddressEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_entity.g.dart';
part 'address_entity.freezed.dart';

@freezed
class AddressEntity with _$AddressEntity {
  const AddressEntity._();

  const factory AddressEntity(
      {required int id,
      required bool isDefault,
      String? unitNumber,
      String? addressLine1,
      String? addressLine2,
      String? country,
      String? streetNumber,
      String? city,
      String? region,
      String? postalCode}) = _AddressEntity;
  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
}

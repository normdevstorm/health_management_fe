import 'package:freezed_annotation/freezed_annotation.dart';
import '../../address/entities/address_entity.dart';
part 'health_provider_entity.freezed.dart';

@freezed
class HealthProviderEntity with _$HealthProviderEntity {
  const HealthProviderEntity._();
  factory HealthProviderEntity({
    required int id,
    String? name,
    String? description,
    AddressEntity? address,
    //todo: check if this property is needed later on
    // final List<Doctor> doctors;
  }) = _HealthProviderEntity;
}

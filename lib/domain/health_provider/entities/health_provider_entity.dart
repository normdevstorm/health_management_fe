import 'package:equatable/equatable.dart';

import '../../address/entities/address_entity.dart';

class HealthProviderEntity extends Equatable {
  final int id;
  final String? name;
  final String? description;
  final AddressEntity? address;
  //todo: check if this property is needed later on
  // final List<Doctor> doctors;
  const HealthProviderEntity(
      {required this.id,
      this.name,
      // required this.doctors,
      this.address,
      this.description});

  @override
  List<Object?> get props => [
        id,
        name,
        // doctors,
        address,
        description
      ];

  HealthProviderEntity copyWith(
      {int? id,
      String? name,
      // List<Doctor>? doctors,
      AddressEntity? address,
      String? description}) {
    return HealthProviderEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        // doctors: doctors ?? this.doctors,
        address: address ?? this.address,
        description: description ?? this.description);
  }
}

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_management/domain/address/entities/address_entity.dart';

class GeolocatorUsecase {
  // Check permissions for location services
  Future<bool> requestLocationServicePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Request permission if it is denied
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get the current position of the device
  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Request permission if it is denied
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      return await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
    } else {
      throw Exception('Location permissions are denied');
    }
  }

  Future<List<Location>> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return locations;
      } else {
        throw Exception('No locations found for the given address');
      }
    } catch (e) {
      throw Exception('Error getting latitude and longitude: $e');
    }
  }

  // Get the distance between two geographical points
  Future<double> getDistanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  // Get the distance between two geographical points in kilometers
  Future<double> getDistanceBetweenDestinationAndCurrentPositionInKilometers(
      AddressEntity destinationAddress) async {
    Position currentPosition = await getCurrentPosition();
    Location endLocation = (await getLatLngFromAddress(
            "${destinationAddress.addressLine1}, ${destinationAddress.addressLine2}, ${destinationAddress.city}"))
        .first;
    double distanceInMeters = await getDistanceBetween(currentPosition.latitude,
        currentPosition.longitude, endLocation.latitude, endLocation.longitude);
    return distanceInMeters / 1000; // Convert meters to kilometers
  }
}

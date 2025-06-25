import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';

void main() async {
  test("Test Geocoding (Translate geo location from address)", () async {
    List<Location> locations =
        await locationFromAddress("Gronausestraat 710, Enschede");
    // expect(locations.isNotEmpty, true);
    // expect(locations.first.latitude, isNotNull);
    // expect(locations.first.longitude, isNotNull);
    print(
        "Latitude: ${locations.first.latitude}, Longitude: ${locations.first.longitude}");
  });
}

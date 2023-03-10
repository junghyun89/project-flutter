import 'package:geolocator/geolocator.dart';

class MyLocation {
  late double latitude;
  late double longitude;

  Future<void> getMyCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('There was a problem with the internet connection.');
    }
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<LocationService> init() async {
    // Initialize the service
    await checkPermission();
    return this;
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Test if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        errorMessage.value =
            'Location services are disabled. Please enable the services';
        return false;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied
          errorMessage.value = 'Location permissions are denied';
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied
        errorMessage.value =
            'Location permissions are permanently denied, we cannot request permissions.';
        return false;
      }

      // Permissions are granted, we can get the location
      return true;
    } catch (e) {
      errorMessage.value = 'Error checking location permission: $e';
      return false;
    }
  }

  Future<Position?> getCurrentPosition() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final hasPermission = await checkPermission();
      if (!hasPermission) {
        isLoading.value = false;
        return null;
      }

      // Get the current position with high accuracy
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      isLoading.value = false;
      return position;
    } catch (e) {
      errorMessage.value = 'Error getting location: $e';
      isLoading.value = false;
      return null;
    }
  }

  // Get last known position (faster but may be less accurate)
  Future<Position?> getLastKnownPosition() async {
    try {
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        currentPosition.value = position;
      }
      return position;
    } catch (e) {
      errorMessage.value = 'Error getting last known location: $e';
      return null;
    }
  }

  // Get continuous location updates
  Stream<Position> getPositionStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}

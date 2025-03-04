import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/location_service.dart';
import '../../controllers/disaster_controller.dart';

class LocationButton extends StatelessWidget {
  final DisasterController controller = Get.find<DisasterController>();
  final LocationService locationService = Get.find<LocationService>();

  LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _handleLocationButtonPress,
              icon: Icon(
                controller.isUsingCurrentLocation.value
                    ? Icons.my_location
                    : Icons.location_searching,
                color: controller.isUsingCurrentLocation.value
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              tooltip: controller.isUsingCurrentLocation.value
                  ? 'Using current location'
                  : 'Use current location',
            ),
            if (locationService.isLoading.value)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
          ],
        ));
  }

  void _handleLocationButtonPress() async {
    if (locationService.isLoading.value) {
      return; // Don't allow multiple presses while loading
    }

    if (controller.isUsingCurrentLocation.value) {
      // If already using location, revert to default city
      controller.fetchWeatherData('Pontianak');
    } else {
      // Get location and update weather
      final position = await locationService.getCurrentPosition();

      if (position != null) {
        // Update coordinates and fetch weather
        controller.latitude.value = position.latitude;
        controller.longitude.value = position.longitude;
        controller.fetchWeatherByLocation();
      } else if (locationService.errorMessage.value.isNotEmpty) {
        // Show error if location service failed
        Get.snackbar(
          'Location Error',
          locationService.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
        );
      }
    }
  }
}

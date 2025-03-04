import 'package:ev_way/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/bmkg_model.dart';
import '../../../models/weather_model.dart';
import '../../../services/weather_service.dart';

class DisasterController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = Get.find<LocationService>();

  // Weather data
  final currentCity = 'Pontianak'.obs;
  final currentTemp = 32.obs;
  final windSpeed = 15.obs;
  final forecastItems = <ForecastItem>[].obs;
  final forecastTemps = [24, 26, 26].obs;

  final weatherIcon = 'clear_day'.obs;
  final isLoading = false.obs;
  final weatherDescription = ''.obs;

  // Location data
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isUsingCurrentLocation = false.obs;

  // Disaster statistics
  final totalDisasters = 480.obs;
  final earthquakes = 16.obs;
  final floods = 208.obs;
  final landslides = 223.obs;
  final volcanicEruptions = 3.obs;
  final extremeWeather = 24.obs;
  final tsunamis = 6.obs;

  // Weather forecast days
  final forecastDays = <String>[].obs;

  // Future<void> getCurrentLocation() async {
  //   final position = await _locationService.getCurrentPosition();

  //   if (position != null) {
  //     latitude.value = position.latitude;
  //     longitude.value = position.longitude;

  //     // Optionally fetch weather using coordinates
  //     // fetchWeatherByLocation();
  //     final WeatherModel? currentWeather =
  //         await _weatherService.getWeatherByCoordinates(-0.019368, 109.309537);
  //     print(currentWeather.toString());
  //   }
  // }

  Future<void> getCurrentLocation() async {
    final position = await _locationService.getCurrentPosition();

    if (position != null) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      // Optionally fetch weather using coordinates
      fetchWeatherByLocation();
      fetchforecast();
    }
  }

  Widget getWeatherIconFromBmkg(ForecastItem forecast, {double size = 32.0}) {
    final IconInfo iconInfo = forecast.getWeatherIcon();

    return Icon(
      iconInfo.icon,
      color: iconInfo.color,
      size: size,
    );
  }

  Future<void> fetchforecast() async {
    if (latitude.value == 0.0 && longitude.value == 0.0) {
      return;
    }

    isLoading.value = true;
    isUsingCurrentLocation.value = true;

    try {
      // Get current weather by coordinates
      final List<ForecastItem>? forecastWeather =
          await _weatherService.getFThreeDaysForecast('61.71.05.1005');

      if (forecastWeather != null) {
        forecastItems.addAll(forecastWeather);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data by location: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeatherByLocation() async {
    if (latitude.value == 0.0 && longitude.value == 0.0) {
      return;
    }

    isLoading.value = true;
    isUsingCurrentLocation.value = true;

    try {
      // Get current weather by coordinates
      final WeatherModel? currentWeather = await _weatherService
          .getWeatherByCoordinates(latitude.value, longitude.value);

      if (currentWeather != null) {
        currentCity.value = currentWeather.cityName;
        currentTemp.value = currentWeather.temperature.round();
        windSpeed.value = currentWeather.windSpeed.round();
        weatherDescription.value = currentWeather.description;
        weatherIcon.value = _getWeatherIcon(currentWeather.icon);

        // // Now get forecast for this location
        // final List<ForecastDay>? forecast = await _weatherService
        //     .getForecastByCoordinates(latitude.value, longitude.value);

        // if (forecast != null && forecast.length >= 3) {
        //   // Update forecast days and temperatures
        //   forecastDays.value = _getIndonesianDayNames(forecast);
        //   forecastTemps.value =
        //       forecast.take(3).map((day) => day.temperature.round()).toList();
        // }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data by location: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeatherData(String city) async {
    isLoading.value = true;
    isUsingCurrentLocation.value = false;

    try {
      // Get current weather
      final WeatherModel? currentWeather =
          await _weatherService.getCurrentWeather(city);

      if (currentWeather != null) {
        currentCity.value = currentWeather.cityName;
        currentTemp.value = currentWeather.temperature.round();
        windSpeed.value = currentWeather.windSpeed.round();
        weatherDescription.value = currentWeather.description;
        weatherIcon.value = _getWeatherIcon(currentWeather.icon);

        // // Get forecast
        // final List<ForecastDay>? forecast =
        //     await _weatherService.getForecast(city);

        // if (forecast != null && forecast.length >= 3) {
        //   // Update forecast days and temperatures
        //   forecastDays.value = _getIndonesianDayNames(forecast);
        //   forecastTemps.value =
        //       forecast.take(3).map((day) => day.temperature.round()).toList();
        // }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to convert OpenWeatherMap icon codes to our internal names
  String _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return 'clear_day';
      case '01n':
        return 'clear_night';
      case '02d':
      case '03d':
      case '04d':
        return 'cloudy';
      case '09d':
      case '10d':
        return 'rainy';
      case '11d':
        return 'thunderstorm';
      case '13d':
        return 'snowy';
      case '50d':
        return 'foggy';
      default:
        return 'clear_day';
    }
  }

  void _initializeNextThreeDays() {
    final List<String> indonesianDays = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];
    final DateTime today = DateTime.now();

    forecastDays.clear();
    for (int i = 1; i <= 3; i++) {
      final DateTime nextDay = today.add(Duration(days: i));
      forecastDays.add(indonesianDays[nextDay.weekday % 7]);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeNextThreeDays();

    getCurrentLocation();

    // fetchWeatherData('Pontianak');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

import 'package:get/get.dart';

import '../models/bmkg_model.dart';
import '../models/weather_model.dart';

class WeatherService extends GetConnect {
  static const String apiKey = '0c05fbf5a8f245ada30c2983a9dd9026';
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/2.5/';

  @override
  void onInit() {
    // IMPORTANT: Make sure the baseUrl ends with a slash
    httpClient.baseUrl = '$baseUrl/';
    httpClient.timeout = const Duration(seconds: 20);

    // Add logging for debugging
    httpClient.addRequestModifier<dynamic>((request) {
      printInfo(info: 'Making request to: ${request.url}');
      return request;
    });

    // Add response modifier for logging or other purposes
    httpClient.addResponseModifier((request, response) {
      printInfo(info: 'Status Code: ${response.statusCode}');
      printInfo(info: 'Data: ${response.bodyString}');
      return response;
    });

    super.onInit();
  }

  // Get current weather for a city
  Future<WeatherModel?> getCurrentWeather(String city) async {
    try {
      final response = await get('/weather', query: {'q': city});

      if (response.status.hasError) {
        printError(
            info: 'Error fetching current weather: ${response.statusText}');
        return null;
      } else {
        return WeatherModel.fromJson(response.body);
      }
    } catch (e) {
      printError(info: 'Exception while fetching current weather: $e');
      return null;
    }
  }

  // Get 5-day forecast
  Future<List<ForecastDay>?> getForecast(String city) async {
    try {
      final response = await get('/forecast', query: {'q': city});

      if (response.status.hasError) {
        printError(info: 'Error fetching forecast: ${response.statusText}');
        return null;
      } else {
        final List<dynamic> forecastList = response.body['list'];

        // Group forecasts by day
        final Map<String, ForecastDay> dailyForecasts = {};

        for (var item in forecastList) {
          final DateTime date =
              DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          final String dateKey = '${date.year}-${date.month}-${date.day}';

          if (!dailyForecasts.containsKey(dateKey)) {
            // Take noon forecast for each day (to represent the day)
            if (date.hour >= 11 && date.hour <= 14) {
              dailyForecasts[dateKey] = ForecastDay(
                date: date,
                temperature: item['main']['temp'],
                icon: item['weather'][0]['icon'],
                description: item['weather'][0]['description'],
              );
            }
          }
        }

        // Sort forecasts by date
        final List<ForecastDay> result = dailyForecasts.values.toList();
        result.sort((a, b) => a.date.compareTo(b.date));

        return result;
      }
    } catch (e) {
      printError(info: 'Exception while fetching forecast: $e');
      return null;
    }
  }

  // Get 5-day forecast
  Future<List<ForecastItem>?> getFThreeDaysForecast(String adm4) async {
    try {
      final response = await get(
          'https://api.bmkg.go.id/publik/prakiraan-cuaca',
          query: {'adm4': adm4});

      if (response.status.hasError) {
        printError(info: 'Error fetching forecast: ${response.statusText}');
        return null;
      } else {
        // Assume jsonData is your decoded JSON (Map<String, dynamic>)
        final BMKGForecastResponse forecastResponse =
            BMKGForecastResponse.fromJson(response.body);

        // We'll use the first ForecastData item (if there are multiple) as an example:
        final ForecastData forecastData = forecastResponse.data.first;

        // Create a list to store the noon forecasts.
        List<ForecastItem> noonForecasts = [];

        // Loop through each group (each group is a list of ForecastItem for a given day).
        for (var group in forecastData.cuaca) {
          try {
            // Look for the forecast item that has a datetime at 12:00:00Z.
            final ForecastItem forecastAtNoon = group.firstWhere(
              (item) => item.datetime.toUtc().hour == 12,
            );
            noonForecasts.add(forecastAtNoon);
          } catch (e) {
            // If no forecast is available at noon for this group, skip it.
            print('No forecast at 12:00:00Z found in one group: $e');
          }
        }

        // If you only want three items, take the first three (if available)
        final List<ForecastItem> threeDayForecast =
            noonForecasts.take(3).toList();
        return threeDayForecast;
      }
    } catch (e) {
      printError(info: 'Exception while fetching forecast: $e');
      return null;
    }
  }

  // Get weather by coordinates
  Future<WeatherModel?> getWeatherByCoordinates(double lat, double lon) async {
    try {
      // final response = await get('/weather', query: {
      //   'lat': lat.toString(),
      //   'lon': lon.toString(),
      // });

      final response = await get('$weatherBaseUrl/weather', query: {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'units': 'metric',
        'appid': apiKey,
        'lang': 'id',
      });

      // print(response.headers);

      if (response.status.hasError) {
        printError(
            info:
                'Error fetching weather by coordinates: ${response.statusText}');
        return null;
      } else {
        return WeatherModel.fromJson(response.body);
      }
    } catch (e) {
      printError(info: 'Exception while fetching weather by coordinates: $e');
      return null;
    }
  }
}

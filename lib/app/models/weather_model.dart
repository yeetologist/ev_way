class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final double? rain1h;
  final int cloudiness;
  final String description;
  final String icon;
  final DateTime timestamp;
  final int timezone;
  final String country;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    this.rain1h,
    required this.cloudiness,
    required this.description,
    required this.icon,
    required this.timestamp,
    required this.timezone,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure:
          json['main']['pressure'] ?? 1013, // Default atmospheric pressure
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] as num?)?.toDouble() ?? 0.0,
      windDeg: json['wind']?['deg'] ?? 0,
      windGust: (json['wind']?['gust'] as num?)?.toDouble(),
      rain1h: (json['rain']?['1h'] as num?)?.toDouble(), // Rain might not exist
      cloudiness: json['clouds']['all'] ?? 0,
      description: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['description']
          : 'No description',
      icon: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['icon']
          : '01d', // Default icon
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          (json['dt'] as int?) != null
              ? json['dt'] * 1000
              : DateTime.now().millisecondsSinceEpoch),
      timezone: json['timezone'] ?? 0,
      country: json['sys']['country'] ?? 'Unknown',
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
    );
  }

  @override
  String toString() {
    return '''
    WeatherModel(
      cityName: $cityName,
      temperature: $temperature°C,
      feelsLike: $feelsLike°C,
      tempMin: $tempMin°C,
      tempMax: $tempMax°C,
      pressure: $pressure hPa,
      humidity: $humidity%,
      windSpeed: $windSpeed m/s,
      windDeg: $windDeg°,
      windGust: ${windGust ?? "N/A"} m/s,
      rain1h: ${rain1h ?? "No rain"} mm,
      cloudiness: $cloudiness%,
      description: $description,
      icon: $icon,
      timestamp: $timestamp,
      timezone: $timezone,
      country: $country,
      sunrise: $sunrise,
      sunset: $sunset
    )
    ''';
  }
}

class ForecastDay {
  final DateTime date;
  final double temperature;
  final String icon;
  final String description;

  ForecastDay({
    required this.date,
    required this.temperature,
    required this.icon,
    required this.description,
  });
}

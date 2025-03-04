import 'package:flutter/material.dart';

class BMKGForecastResponse {
  final Location lokasi;
  final List<ForecastData> data;

  BMKGForecastResponse({
    required this.lokasi,
    required this.data,
  });

  factory BMKGForecastResponse.fromJson(Map<String, dynamic> json) {
    return BMKGForecastResponse(
      lokasi: Location.fromJson(json['lokasi']),
      data:
          (json['data'] as List).map((e) => ForecastData.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'BMKGForecastResponse(lokasi: $lokasi, data: $data)';
  }
}

class Location {
  final String adm1;
  final String adm2;
  final String adm3;
  final String adm4;
  final String provinsi;
  final String kotkab;
  final String kecamatan;
  final String desa;
  final double lon;
  final double lat;
  final String timezone;

  Location({
    required this.adm1,
    required this.adm2,
    required this.adm3,
    required this.adm4,
    required this.provinsi,
    required this.kotkab,
    required this.kecamatan,
    required this.desa,
    required this.lon,
    required this.lat,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      adm1: json['adm1'] ?? '',
      adm2: json['adm2'] ?? '',
      adm3: json['adm3'] ?? '',
      adm4: json['adm4'] ?? '',
      provinsi: json['provinsi'] ?? '',
      kotkab: json['kotkab'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      desa: json['desa'] ?? '',
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      timezone: json['timezone'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Location(adm1: $adm1, adm2: $adm2, adm3: $adm3, adm4: $adm4, provinsi: $provinsi, kotkab: $kotkab, kecamatan: $kecamatan, desa: $desa, lon: $lon, lat: $lat, timezone: $timezone)';
  }
}

class ForecastData {
  final Location lokasi;

  /// "cuaca" is a list of forecast groups, where each group is a list of ForecastItem objects.
  final List<List<ForecastItem>> cuaca;

  ForecastData({
    required this.lokasi,
    required this.cuaca,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      lokasi: Location.fromJson(json['lokasi']),
      cuaca: (json['cuaca'] as List)
          .map((group) => (group as List)
              .map((item) => ForecastItem.fromJson(item))
              .toList())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ForecastData(lokasi: $lokasi, cuaca: $cuaca)';
  }
}

class ForecastItem {
  final DateTime datetime;
  final int t; // Temperature
  final int tcc; // Cloud cover (%)
  final double tp; // Precipitation (mm)
  final int weather;
  final String weatherDesc;
  final String weatherDescEn;
  final int wdDeg;
  final String wd;
  final String wdTo;
  final double ws; // Wind speed
  final int hu; // Humidity
  final int vs;
  final String vsText;
  final String timeIndex;
  final DateTime analysisDate;
  final String image;
  final DateTime utcDatetime;
  final DateTime localDatetime;

  ForecastItem({
    required this.datetime,
    required this.t,
    required this.tcc,
    required this.tp,
    required this.weather,
    required this.weatherDesc,
    required this.weatherDescEn,
    required this.wdDeg,
    required this.wd,
    required this.wdTo,
    required this.ws,
    required this.hu,
    required this.vs,
    required this.vsText,
    required this.timeIndex,
    required this.analysisDate,
    required this.image,
    required this.utcDatetime,
    required this.localDatetime,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      datetime: DateTime.parse(json['datetime']),
      t: json['t'],
      tcc: json['tcc'],
      tp: (json['tp'] as num).toDouble(),
      weather: json['weather'],
      weatherDesc: json['weather_desc'] ?? '',
      weatherDescEn: json['weather_desc_en'] ?? '',
      wdDeg: json['wd_deg'],
      wd: json['wd'] ?? '',
      wdTo: json['wd_to'] ?? '',
      ws: (json['ws'] as num).toDouble(),
      hu: json['hu'],
      vs: json['vs'],
      vsText: json['vs_text'] ?? '',
      timeIndex: json['time_index'] ?? '',
      analysisDate: DateTime.parse(json['analysis_date']),
      image: json['image'] ?? '',
      utcDatetime: DateTime.parse(json['utc_datetime']),
      localDatetime: DateTime.parse(json['local_datetime']),
    );
  }

  // Get temperature as double
  double getTemperatureValue() {
    // Extract number from string like "25°C"
    return double.tryParse(t.toString().replaceAll('°C', '')) ?? 0.0;
  }

  // Get a short version of the weather description
  String getShortWeatherDesc() {
    // If the description is too long, truncate it
    if (weatherDesc.length > 15) {
      return '${weatherDesc.substring(0, 12)}...';
    }
    return weatherDesc;
  }

  // Get icon data based on weather code and description
  IconInfo getWeatherIcon() {
    switch (weather) {
      case 0: // Clear sky
        return IconInfo(Icons.wb_sunny, Colors.amber);
      case 1: // Partly cloudy
      case 2: // Partly cloudy
        return IconInfo(Icons.wb_cloudy, Colors.amber);
      case 3: // Mostly cloudy
      case 4: // Overcast
        return IconInfo(Icons.cloud, Colors.grey);
      case 5: // Haze
      case 45: // Fog
        return IconInfo(Icons.cloud, Colors.blueGrey);
      case 60: // Light rain
      case 61: // Rain
        return IconInfo(Icons.grain, Colors.blue);
      case 63: // Heavy rain
      case 80: // Rain showers
        return IconInfo(Icons.beach_access, Colors.blue);
      case 95: // Thunderstorm
      case 97: // Heavy thunderstorm
        return IconInfo(Icons.flash_on, Colors.amber);
      default:
        return IconInfo(Icons.wb_sunny, Colors.amber);
    }
  }

  @override
  String toString() {
    return '''
ForecastItem(
  datetime: $datetime,
  t: $t°C,
  tcc: $tcc%,
  tp: ${tp.toStringAsFixed(1)} mm,
  weather: $weather,
  weatherDesc: $weatherDesc,
  weatherDescEn: $weatherDescEn,
  wdDeg: $wdDeg°,
  wd: $wd,
  wdTo: $wdTo,
  ws: ${ws.toStringAsFixed(1)} m/s,
  hu: $hu%,
  vs: $vs,
  vsText: $vsText,
  timeIndex: $timeIndex,
  analysisDate: $analysisDate,
  image: $image,
  utcDatetime: $utcDatetime,
  localDatetime: $localDatetime
)''';
  }
}

// Helper class for icon information
class IconInfo {
  final IconData icon;
  final Color color;

  IconInfo(this.icon, this.color);
}

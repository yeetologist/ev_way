import 'package:ev_way/app/modules/disaster/controllers/disaster_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherCard extends StatelessWidget {
  final DisasterController controller = Get.find();

  WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cuaca',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            Obx(() => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saat ini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          controller.currentCity.value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Angin ${controller.windSpeed.value} m/s',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        _getWeatherIcon(controller.weatherIcon.value),
                        const SizedBox(width: 4),
                        Text(
                          '${controller.currentTemp.value}°',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      List.generate(3, (index) => _buildForecastDay(index)),
                )),
          ],
        ),
      ),
    );
  }

  Widget _getWeatherIcon(String iconType) {
    IconData iconData;
    Color iconColor;

    switch (iconType) {
      case 'clear_day':
        iconData = Icons.wb_sunny;
        iconColor = Colors.amber;
        break;
      case 'clear_night':
        iconData = Icons.nightlight_round;
        iconColor = Colors.indigo;
        break;
      case 'cloudy':
        iconData = Icons.cloud;
        iconColor = Colors.grey;
        break;
      case 'rainy':
        iconData = Icons.grain;
        iconColor = Colors.blue;
        break;
      case 'thunderstorm':
        iconData = Icons.flash_on;
        iconColor = Colors.amber;
        break;
      case 'snowy':
        iconData = Icons.ac_unit;
        iconColor = Colors.lightBlue;
        break;
      case 'foggy':
        iconData = Icons.cloud;
        iconColor = Colors.blueGrey;
        break;
      default:
        iconData = Icons.wb_sunny;
        iconColor = Colors.amber;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 32,
    );
  }

  Widget _buildForecastDay(int index) {
    if (controller.forecastItems.isNotEmpty &&
        index < controller.forecastItems.length) {
      final forecast = controller.forecastItems[index];

      return Column(
        children: [
          Text(
            controller.forecastDays[index],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 2),
          controller.getWeatherIconFromBmkg(forecast, size: 14.0),
          const SizedBox(height: 2),
          Text(
            "${forecast.t.round().toString()}°",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            controller.forecastDays[index],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 2),
          const Icon(
            Icons.wb_sunny,
            color: Colors.amber,
            size: 14,
          ),
          const SizedBox(height: 2),
          Text(
            '${controller.forecastTemps[index]}°C',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
  }
}

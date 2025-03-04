import 'package:ev_way/app/modules/disaster/views/widgets/disaster_card_stat.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/preparation_card.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/weather_card.dart';
import 'package:ev_way/app/modules/welcome/views/widgets/concentric_circles_background.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/disaster_controller.dart';
import 'widgets/location_button.dart';

class DisasterView extends GetView<DisasterController> {
  const DisasterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xFFF15A38),
        ),
        Positioned(
          left: -70, // Move left to create partial circle
          top: 70, // Move up to create partial circle
          child: CustomPaint(
            painter: ConcentricCirclesPainter(
              primaryColor: const Color(0xFFF15A38),
              secondaryColor: const Color(0xFFF47857),
              circleCount: 6,
              maxRadiusRatio: 0.8,
            ),
            child: SizedBox(width: 200, height: 200),
          ),
        ),
        Positioned(
          right: -70, // Move left to create partial circle
          top: -50, // Move up to create partial circle
          child: CustomPaint(
            painter: ConcentricCirclesPainter(
              primaryColor: const Color(0xFFF15A38),
              secondaryColor: const Color(0xFFF47857),
              circleCount: 6,
              maxRadiusRatio: 0.8,
            ),
            child: SizedBox(width: 200, height: 200),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Sigap Bencana',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            actions: [
              LocationButton(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (controller.isUsingCurrentLocation.value) {
                    controller.fetchWeatherByLocation();
                  } else {
                    controller.fetchWeatherData(controller.currentCity.value);
                  }
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0, // Remove AppBar shadow
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather and total disasters section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildTopSection(context),
                ),
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Disaster types grid
                        _buildDisasterGrid(),
                        const SizedBox(height: 24),

                        // Disaster preparation section
                        _buildPreparationSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      children: [
        // Total disasters card
        Expanded(
          flex: 4,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Bencana',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        '${controller.totalDisasters.value}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Weather card
        Expanded(
          flex: 6,
          child: WeatherCard(),
        ),
      ],
    );
  }

  Widget _buildDisasterGrid() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DisasterStatCard(
          title: 'Gempa',
          count: controller.earthquakes,
          icon: Icons.location_on,
          color: const Color(0xFFEA9854),
        ),
        DisasterStatCard(
          title: 'Banjir',
          count: controller.floods,
          icon: Icons.water,
          color: const Color(0xFFEA9854),
        ),
        DisasterStatCard(
          title: 'Tanah Longsor',
          count: controller.landslides,
          icon: Icons.terrain,
          color: const Color(0xFFEA9854),
        ),
        DisasterStatCard(
          title: 'Erupsi Gunung Api',
          count: controller.volcanicEruptions,
          icon: Icons.landscape,
          color: const Color(0xFFEA9854),
        ),
        DisasterStatCard(
          title: 'Cuaca Ekstrim',
          count: controller.extremeWeather,
          icon: Icons.thunderstorm,
          color: const Color(0xFFEA9854),
        ),
        DisasterStatCard(
          title: 'Tsunami',
          count: controller.tsunamis,
          icon: Icons.waves,
          color: const Color(0xFFEA9854),
        ),
      ],
    );
  }

  Widget _buildPreparationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Persiapan Bencana',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF76C5E),
          ),
        ),
        const SizedBox(height: 16),
        PreparationCard(
          title: 'Tips dan Langkah Persiapan Bencana',
          imagePath: 'assets/images/disaster_preparation.svg',
          onTap: () => Get.toNamed('/preparation-tips'),
        ),
        const SizedBox(height: 12),
        PreparationCard(
          title: 'Tindakan Saat Bencana',
          imagePath: 'assets/images/during_disaster.svg',
          onTap: () => Get.toNamed('/during-disaster'),
        ),
        const SizedBox(height: 12),
        PreparationCard(
          title: 'Pasca Bencana',
          imagePath: 'assets/images/post_disaster.svg',
          onTap: () => Get.toNamed('/post-disaster'),
        ),
      ],
    );
  }
}

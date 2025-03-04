import 'package:ev_way/app/modules/disaster/controllers/disaster_controller.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/disaster_card_stat.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/location_button.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/preparation_card.dart';
import 'package:ev_way/app/modules/disaster/views/widgets/weather_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// Create this class in a separate file like 'circular_background.dart'
class CircularBackground extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const CircularBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color
        Container(
          color: backgroundColor,
        ),

        // Top left circles
        Positioned(
          left: -60,
          top: -20,
          child: _buildCircleGroup(context),
        ),

        // Top right circles
        Positioned(
          right: -70,
          top: -50,
          child: _buildCircleGroup(context),
        ),

        // The main content
        child,
      ],
    );
  }

  Widget _buildCircleGroup(BuildContext context) {
    final lighterColor = HSLColor.fromColor(backgroundColor)
        .withLightness((HSLColor.fromColor(backgroundColor).lightness + 0.1)
            .clamp(0.0, 1.0))
        .toColor();

    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer circle (largest, most transparent)
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lighterColor.withValues(alpha: 0.3),
          ),
        ),

        // Middle circle
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lighterColor.withValues(alpha: 0.5),
          ),
        ),

        // Inner circle (smallest, most opaque)
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lighterColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

// Then in your DisasterView class, just wrap the Scaffold with CircularBackground:

class DisasterView extends GetView<DisasterController> {
  const DisasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularBackground(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        // Make scaffold background transparent to let the circles show through
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Sigap Bencana',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            LocationButton(),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                if (controller.isUsingCurrentLocation.value) {
                  controller.fetchWeatherByLocation();
                } else {
                  controller.fetchWeatherData(controller.currentCity.value);
                }
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent, // Make app bar transparent
          elevation: 0, // Remove app bar shadow
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather and total disasters section
                _buildTopSection(),
                const SizedBox(height: 20),

                // Disaster types grid
                _buildDisasterGrid(),
                const SizedBox(height: 24),

                // Disaster preparation section
                _buildPreparationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Your existing methods remain unchanged
  Widget _buildTopSection() {
    // Your existing implementation
    return Row(
      children: [
        // Total disasters card
        Expanded(
          flex: 4,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Bencana',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        '${controller.totalDisasters.value}',
                        style: const TextStyle(
                          color: Colors.white,
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
    // Your existing implementation
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
    // Your existing implementation
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Persiapan Bencana',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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

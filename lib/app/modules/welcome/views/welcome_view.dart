import 'package:ev_way/app/modules/welcome/views/widgets/concentric_circles_background.dart';
import 'package:ev_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ConcentricCirclesBackground(),
          // Logo
          Center(
            child: SvgPicture.asset(
              'assets/icons/evway_logo.svg',
              height: 200,
              width: 200,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Welcome card
                Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Welcome text
                        const Text(
                          'Selamat Datang!',
                          style: TextStyle(
                            color: Color(0xFFF15A38),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selamatkan Hidupmu, Evakuasi dengan Aman',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF5B6B8C),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to login page
                              Get.toNamed(Routes.login);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF26BDB9),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Register button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to register page
                              Get.toNamed(Routes.register);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF26BDB9),
                              side: const BorderSide(
                                color: Color(0xFF26BDB9),
                                width: 1,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

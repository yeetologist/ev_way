import 'package:ev_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both username and password',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 2));

    // Add your actual login logic here
    // For example: authService.login(username, password)

    isLoading.value = false;

    // Navigate to home screen after successful login
    // Get.offAll(() => HomeScreen());
  }

  void forgotPassword() {
    // Navigate to forgot password screen
    // Get.to(() => ForgotPasswordScreen());
  }

  void register() {
    // Navigate to registration screen
    Get.toNamed(Routes.REGISTER);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

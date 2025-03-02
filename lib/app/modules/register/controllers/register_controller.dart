import 'package:ev_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;
  final agreeToTerms = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  String? validateUsername() {
    if (usernameController.text.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    return null;
  }

  String? validatePhone() {
    if (phoneController.text.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    if (!GetUtils.isPhoneNumber(phoneController.text)) {
      return 'Nomor telepon tidak valid';
    }
    return null;
  }

  String? validateEmail() {
    if (emailController.text.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(emailController.text)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? validatePassword() {
    if (passwordController.text.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (passwordController.text.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  String? validateConfirmPassword() {
    if (confirmPasswordController.text.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (confirmPasswordController.text != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  bool validateForm() {
    final usernameValid = validateUsername() == null;
    final phoneValid = validatePhone() == null;
    final emailValid = validateEmail() == null;
    final passwordValid = validatePassword() == null;
    final confirmPasswordValid = validateConfirmPassword() == null;

    return usernameValid &&
        phoneValid &&
        emailValid &&
        passwordValid &&
        confirmPasswordValid &&
        agreeToTerms.value;
  }

  void register() async {
    if (!validateForm()) {
      Get.snackbar(
        'Error',
        'Harap lengkapi form dengan benar',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 2));

    // Add your actual registration logic here
    // For example: authService.register(username, email, password)

    isLoading.value = false;

    // Navigate to verification or login screen after successful registration
    Get.snackbar(
      'Sukses',
      'Registrasi berhasil! Silahkan login',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    );

    // Go to login screen
    // Get.offNamed('/login');
  }

  void navigateToLogin() {
    // Navigate to login screen
    Get.toNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

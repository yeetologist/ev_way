import 'package:ev_way/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Navigate to home screen after successful login
        Get.offAllNamed(Routes.LANDING);
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      String message = 'An error occurred during login';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }

      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
  }

  // void forgotPassword() {
  //   // Navigate to forgot password screen
  //   // Get.to(() => ForgotPasswordScreen());
  // }
  Future<void> forgotPassword() async {
    if (usernameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: usernameController.text.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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

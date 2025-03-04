import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_way/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> register() async {
    if (!validateForm()) {
      Get.snackbar(
        'Error',
        'Please complete the form correctly',
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Store additional user information in Firestore
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': usernameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Send email verification
        // await userCredential.user!.sendEmailVerification();

        Get.snackbar(
          'Success',
          'Registration successful! Please verify your email.',
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to login screen
        Get.offNamed(Routes.login);
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      String message = 'Registration failed';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }

      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
  }

  void navigateToLogin() {
    // Navigate to login screen
    Get.toNamed(Routes.login);
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

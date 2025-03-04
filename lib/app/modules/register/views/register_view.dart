import 'package:ev_way/app/modules/welcome/views/widgets/concentric_circles_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF15A38), // Orange background
      body: Stack(
        children: [
          ConcentricCirclesBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: (24.0)),
                child: SvgPicture.asset(
                  'assets/icons/evway_logo.svg',
                  height: 100,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Register Title
                          const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF15A38),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Subtitle
                          const Text(
                            'Buat akun baru untuk menggunakan aplikasi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Username Field
                          _buildInputField(
                            label: 'Username',
                            hint: 'Masukkan username',
                            controller: controller.usernameController,
                          ),
                          const SizedBox(height: 16),

                          // Phone Field
                          _buildInputField(
                            label: 'Nomor Telepon',
                            hint: 'Masukkan nomor telepon',
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          _buildInputField(
                            label: 'Email',
                            hint: 'Masukkan email',
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          _buildPasswordField(
                            label: 'Password',
                            hint: 'Masukkan password',
                            controller: controller.passwordController,
                            isVisible: controller.isPasswordVisible,
                            toggleVisibility:
                                controller.togglePasswordVisibility,
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password Field
                          _buildPasswordField(
                            label: 'Konfirmasi Password',
                            hint: 'Masukkan ulang password',
                            controller: controller.confirmPasswordController,
                            isVisible: controller.isConfirmPasswordVisible,
                            toggleVisibility:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          const SizedBox(height: 20),

                          // Terms and Conditions Checkbox
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.agreeToTerms.value,
                                  onChanged: (value) =>
                                      controller.toggleAgreeToTerms(),
                                  activeColor: const Color(0xFF26BDB9),
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Saya setuju dengan ',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: 'Syarat dan Ketentuan',
                                        style: const TextStyle(
                                          color: Color(0xFF26BDB9),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // You can add a gesture recognizer here if needed
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Register Button
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value ||
                                        !controller.agreeToTerms.value
                                    ? null
                                    : controller.register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF26BDB9),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                  disabledBackgroundColor:
                                      const Color(0xFF26BDB9)
                                          .withValues(alpha: 0.6),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Daftar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Login Link
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sudah punya akun? ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.navigateToLogin,
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF26BDB9),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build text input fields
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFF15A38),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.withValues(alpha: 0.5),
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFFF15A38).withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build password input fields
  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required RxBool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFF15A38),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller,
            obscureText: !isVisible.value,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: const Color(0xFFF15A38).withValues(alpha: 0.3),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

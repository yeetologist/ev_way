import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String age;
  final String birthDate;
  final String gender;
  final String address;

  const PersonalInfoCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.age,
    required this.birthDate,
    required this.gender,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F2), // Light pink background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nama Lengkap', name),
            _buildDivider(),
            _buildInfoRow('Nomor HP', phoneNumber),
            _buildDivider(),
            _buildInfoRow('Umur', age),
            _buildDivider(),
            _buildInfoRow('Tanggal Lahir', birthDate),
            _buildDivider(),
            _buildInfoRow('Jenis Kelamin', gender),
            _buildDivider(),
            _buildInfoRow('Alamat', address),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6A7B9C), // Slate blue-gray color
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF6A7B9C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFFE0E0E0),
      thickness: 1,
    );
  }
}

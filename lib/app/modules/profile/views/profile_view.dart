import 'package:ev_way/app/modules/profile/views/widgets/personal_info_card.dart';
import 'package:ev_way/app/modules/profile/views/widgets/profile_picture.dart';
import 'package:ev_way/app/modules/profile/views/widgets/settings_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProfilePictureWidget(
                  imageUrl:
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your image path
                  // For network image use: 'https://example.com/profile.jpg'
                  size: 120,
                  onCameraTap: () {
                    // Handle camera button tap (e.g., open image picker)
                    print('Camera button tapped');
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Data Diri Pengguna',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  ),
                ),
              ),
              PersonalInfoCard(
                name: 'Ribka',
                phoneNumber: '083991649123',
                age: '30 Tahun',
                birthDate: '19 Juni 1993',
                gender: 'Wanita',
                address:
                    'Jalan Silat Baru No. K.51, Bansir Laut, Pontianak Tenggara, Kota Pontianak, Kalimantan barat',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Pengaturan',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  ),
                ),
              ),
              SettingsButton(
                text: 'Pengaturan Akun',
                icon: Icons
                    .person_outline, // You can change this to any Flutter icon
                onTap: () {
                  // What happens when button is tapped
                },
              ),
              SettingsButton(
                text: 'Pengatuan Aplikasi',
                icon: Icons.settings_outlined,
                onTap: () {
                  // What happens when button is tapped
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

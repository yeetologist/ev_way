import 'package:ev_way/app/modules/about/views/widgets/about_list_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(
          'Tentang',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          AboutListItem(
            title: 'Profil Aplikasi',
            icon: Icons.info_outline,
            onTap: () {
              // Handle app profile tap
            },
          ),
          AboutListItem(
            title: 'Kebijakan Privasi',
            icon: Icons.privacy_tip_outlined,
            onTap: () {
              // Handle privacy policy tap
            },
          ),
          AboutListItem(
            title: 'Syarat dan Ketentuan',
            icon: Icons.description_outlined,
            onTap: () {
              // Handle terms and conditions tap
            },
          ),
          AboutListItem(
            title: 'Kontak Kami',
            icon: Icons.headset_mic_outlined,
            onTap: () {
              // Handle contact us tap
            },
          ),
        ],
      ),
    );
  }
}

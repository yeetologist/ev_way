import 'package:flutter/material.dart';

class PreparationTipsPage extends StatelessWidget {
  const PreparationTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips dan Langkah Persiapan Bencana'),
        backgroundColor: const Color(0xFFF76C5E),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          PreparationTipItem(
            title: 'Siapkan Tas Siaga Bencana',
            description:
                'Siapkan tas dengan barang penting seperti obat-obatan, dokumen, makanan tahan lama, air, dan pakaian.',
            icon: Icons.backpack,
          ),
          PreparationTipItem(
            title: 'Kenali Rute Evakuasi',
            description:
                'Pelajari dan latih rute evakuasi dari rumah dan tempat kerja Anda.',
            icon: Icons.directions,
          ),
          // Add more tips as needed
        ],
      ),
    );
  }
}

class PreparationTipItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const PreparationTipItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF76C5E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFF76C5E),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

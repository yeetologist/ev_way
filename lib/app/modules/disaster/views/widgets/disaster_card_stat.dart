import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisasterStatCard extends StatelessWidget {
  final String title;
  final RxInt count;
  final IconData icon;
  final Color color;

  const DisasterStatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
                const SizedBox(width: 4),
                Obx(() => Text(
                      '${count.value}',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

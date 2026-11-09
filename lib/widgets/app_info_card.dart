import 'package:flutter/material.dart';

class InfoShowcaseCard extends StatelessWidget {
  final String nama;
  final String nim;
  final VoidCallback? onTap;

  const InfoShowcaseCard({
    super.key,
    required this.nama,
    required this.nim,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border.all(color: Colors.blue.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.restaurant_menu,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recipes.io v1.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dikembangkan oleh $nama ($nim).',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 20,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue.shade800,
              size: 10,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';

class ProfileTab extends StatelessWidget {
  final String nama;
  final String nim;

  const ProfileTab({
    super.key,
    required this.nama,
    required this.nim,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(fontWeight: FontWeight.w900), 
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ─── HEADER PROFIL ───
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Nama
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  // NIM
                  Text(
                    'NIM: $nim',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── INFO CARDS ───
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  InfoCard(
                    icon: Icons.school,
                    title: 'Program Studi',
                    subtitle: 'Pendidikan Teknik Informatika',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    icon: Icons.class_,
                    title: 'Kelas',
                    subtitle: 'PTI 5A',
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    icon: Icons.code,
                    title: 'Project UTS',
                    subtitle: 'Recipes.io - Food Finder App',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── FOOTER / TENTANG APLIKASI ───
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.restaurant_menu, size: 40, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text(
                    'Recipes.io v1.0',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dibuat untuk memenuhi Ujian Tengah Semester\nPemrograman Mobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
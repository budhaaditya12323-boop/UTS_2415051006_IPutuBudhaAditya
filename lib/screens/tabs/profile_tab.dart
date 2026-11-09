import 'package:flutter/material.dart';

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
    return Center(
      child: Text('Profile Tab, $nama, $nim'),
    );
  }
}
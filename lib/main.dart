import 'package:flutter/material.dart';
import 'package:recepies_io/screens/main_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recepies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 238, 153, 24),
      ),
      home: const MainShell(
        nama: "I Putu Budha Aditya",
        nim: "2415051006",
      ),
    );
  }
}
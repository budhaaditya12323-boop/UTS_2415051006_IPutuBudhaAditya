import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:recepies_io/providers/meal_provider.dart'; // Import provider
import 'package:recepies_io/screens/main_shell.dart';

void main() {
  runApp(
    // Bungkus aplikasi dengan Provider
    ChangeNotifierProvider(
      create: (_) => MealProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResepKita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const MainShell(
        nama: "I Putu Budha Aditya",
        nim: "2415051006",
      ),
    );
  }
}
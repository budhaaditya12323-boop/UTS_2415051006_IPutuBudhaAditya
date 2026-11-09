import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:recepies_io/providers/meal_provider.dart'; // Import provider
import 'package:recepies_io/screens/main_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ofejigiqdluytosikivj.supabase.co',
    publishableKey: 'sb_publishable_4WV1JMDVrC6jcvO-EsanXw_sqUXNvyY',
  );

  runApp(
    // Bungkus aplikasi dengan Provider
    ChangeNotifierProvider(
      create: (_) => MealProvider()..loadSavedRecipes(),
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
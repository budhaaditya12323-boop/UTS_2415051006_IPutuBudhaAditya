import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:recepies_io/providers/meal_provider.dart'; 
import 'package:recepies_io/screens/main_shell.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'repositories/meal_repository.dart';
import 'repositories/saved_recipe_repository.dart';
import 'services/meal_api_service.dart';
import 'services/supabase_service.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ofejigiqdluytosikivj.supabase.co',
    publishableKey: 'sb_publishable_4WV1JMDVrC6jcvO-EsanXw_sqUXNvyY',
  );

  final mealApiService = MealApiService();
  final supabaseService = SupabaseService();

  final mealRepository = MealRepository(mealApiService);
  final savedRecipeRepository = SavedRecipeRepository(supabaseService);

  runApp(
    // Bungkus aplikasi dengan Provider
    ChangeNotifierProvider(
      create: (_) => MealProvider(mealRepository, savedRecipeRepository)..loadSavedRecipes(),
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
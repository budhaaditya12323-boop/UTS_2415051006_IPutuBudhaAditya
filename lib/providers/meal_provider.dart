import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';
import '../models/saved_recepies.dart';
import '../services/supabase_service.dart';

class MealProvider extends ChangeNotifier {
  final MealApiService _apiService = MealApiService();
  final SupabaseService _dbService = SupabaseService();

  // === STATE API ===
  List<Meal> _meals = [];
  bool _isLoading = false;
  String? _error;
  List<Meal> get meals => _meals;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // === STATE DATABASE ===
  List<SavedRecipe> _savedRecipes = [];
  bool _isDbLoading = false;
  List<SavedRecipe> get savedRecipes => _savedRecipes;
  bool get isDbLoading => _isDbLoading;

    Future<void> loadRandomMeals() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final m1 = await _apiService.getRandomMeals();
      final m2 = await _apiService.getRandomMeals();
      final m3 = await _apiService.getRandomMeals();
      
      _meals = [...m1, ...m2, ...m3]; 
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSavedRecipes() async {
    _isDbLoading = true;
    notifyListeners();
    try {
      _savedRecipes = await _dbService.getSavedRecipes();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isDbLoading = false;
      notifyListeners();
    }
  }
}

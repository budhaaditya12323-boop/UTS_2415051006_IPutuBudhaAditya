import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';
import '../models/saved_recipe.dart';
import '../services/supabase_service.dart';

class MealProvider extends ChangeNotifier {
  final MealApiService _apiService = MealApiService();
  final SupabaseService _dbService = SupabaseService();
  bool _isChecking = false;
  bool get isChecking => _isChecking;

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

    Future<void> searchMeals(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); 

    try {
      _meals = await _apiService.searchMeals(query);
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }

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

  Future<String> saveRecipe(SavedRecipe recipe) async {
   _isChecking = true;
    notifyListeners();

    try {
      final bool exists = await _dbService.isRecipeSaved(recipe.mealId);

      if (exists) {
        return 'Resep ini sudah ada di daftar Favorit!';
      }

      await _dbService.addSavedRecipe(recipe);
      await loadSavedRecipes();
      
      return 'Berhasil disimpan ke Favorit!';
      
    } catch (e) {
      return 'Terjadi kesalahan: ${e.toString()}';
    } finally {
      _isChecking = false;
      notifyListeners();
    }
  }
  Future<void> updateNote(int id, String newNote) async {
    await _dbService.updateSavedRecipe(id, newNote);
    await loadSavedRecipes(); 
  }
  Future<void> deleteRecipe(int id) async {
    await _dbService.deleteSavedRecipe(id);
    await loadSavedRecipes(); 
  }
}

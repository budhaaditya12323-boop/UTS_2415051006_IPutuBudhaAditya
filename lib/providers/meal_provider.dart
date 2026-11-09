import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../models/saved_recipe.dart';
import '../repositories/meal_repository.dart';
import '../repositories/saved_recipe_repository.dart';

class MealProvider extends ChangeNotifier {
  // ─── GUNAKAN REPOSITORY ───
  final MealRepository _mealRepo;
  final SavedRecipeRepository _recipeRepo;

  // Constructor menerima Repository dari main.dart
  MealProvider(this._mealRepo, this._recipeRepo);

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

  // === STATE CHECKING (Cek Duplikat) ===
  bool _isChecking = false;
  bool get isChecking => _isChecking;

  // ─── FUNGSI API ───

  Future<void> searchMeals(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); 

    try {
      _meals = await _mealRepo.searchMeals(query); // Panggil Repo
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
      final m1 = await _mealRepo.getRandomMeals(); // Panggil Repo
      final m2 = await _mealRepo.getRandomMeals();
      final m3 = await _mealRepo.getRandomMeals();
      
      _meals = [...m1, ...m2, ...m3]; 
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Meal?> fetchMealForDetail(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final meal = await _mealRepo.getMealById(id); // Panggil Repo
      return meal;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── FUNGSI DATABASE ───

  Future<void> loadSavedRecipes() async {
    _isDbLoading = true;
    notifyListeners();
    try {
      _savedRecipes = await _recipeRepo.getSavedRecipes(); // Panggil Repo
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
      final bool exists = await _recipeRepo.isRecipeSaved(recipe.mealId); // Panggil Repo

      if (exists) {
        return 'Resep ini sudah ada di daftar Favorit!';
      }

      await _recipeRepo.addSavedRecipe(recipe); // Panggil Repo
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
    await _recipeRepo.updateSavedRecipe(id, newNote); // Panggil Repo
    await loadSavedRecipes(); 
  }

  Future<void> deleteRecipe(int id) async {
    await _recipeRepo.deleteSavedRecipe(id); // Panggil Repo
    await loadSavedRecipes(); 
  }
}
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';

class MealProvider extends ChangeNotifier {
  final MealApiService _apiService = MealApiService();

  List<Meal> _meals = [];
  bool _isLoading = false;
  String? _error;

  List<Meal> get meals => _meals;
  bool get isLoading => _isLoading;
  String? get error => _error;

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
}
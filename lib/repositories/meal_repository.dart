import '../models/meal.dart';
import '../services/meal_api_service.dart';

class MealRepository {
  final MealApiService _apiService;

  MealRepository(this._apiService);

  Future<List<Meal>> searchMeals(String query) => _apiService.searchMeals(query);
  Future<List<Meal>> getRandomMeals() => _apiService.getRandomMeals();
  Future<Meal> getMealById(String id) => _apiService.getMealById(id);
}
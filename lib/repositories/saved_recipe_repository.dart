import '../models/saved_recipe.dart';
import '../services/supabase_service.dart';

class SavedRecipeRepository {
  final SupabaseService _dbService;

  SavedRecipeRepository(this._dbService);

  Future<List<SavedRecipe>> getSavedRecipes() => _dbService.getSavedRecipes();
  Future<bool> isRecipeSaved(String mealId) => _dbService.isRecipeSaved(mealId);
  Future<void> addSavedRecipe(SavedRecipe recipe) => _dbService.addSavedRecipe(recipe);
  Future<void> updateSavedRecipe(int id, String newNote) => _dbService.updateSavedRecipe(id, newNote);
  Future<void> deleteSavedRecipe(int id) => _dbService.deleteSavedRecipe(id);
}
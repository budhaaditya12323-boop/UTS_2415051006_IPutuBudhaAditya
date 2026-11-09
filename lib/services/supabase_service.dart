import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_recepies.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<SavedRecipe>> getSavedRecipes() async {
    final response = await supabase
        .from('saved_recipes')
        .select()
        .order('id', ascending: false);

    return (response as List)
        .map((json) => SavedRecipe.fromJson(json))
        .toList();
  }
  Future<void> addSavedRecipe(SavedRecipe recipe) async {
    await supabase.from('saved_recipes').insert(recipe.toJson());
  }
  Future<void> updateSavedRecipe(int id, String newNote) async {
    await supabase
        .from('saved_recipes')
        .update({'note': newNote})
        .eq('id', id);
  }
}
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
}
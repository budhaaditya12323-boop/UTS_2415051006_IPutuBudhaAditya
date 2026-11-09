import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';
import '../../widgets/saved_recipe_card.dart';
import '../meal_detail_pages.dart';
import '../../models/meal.dart';
import '../edit_note_screen.dart';
import '../../widgets/error_view.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (provider.isDbLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.dbError != null) {
            return ErrorView(
              message: provider.dbError!,
              onRetry: () => provider.loadSavedRecipes(), 
            );
          }
          if (provider.savedRecipes.isEmpty) {
            return const ErrorView(
              message: 'Belum ada resep favorit.\nAyo simpan resep pertamamu!',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.savedRecipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.savedRecipes[index];
              return SavedRecipeCard(
                recipe: recipe,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNoteScreen(
                        id: recipe.id!,
                        currentNote: recipe.note,
                      ),
                    ),
                  );
                },
                onDelete: () => _showDeleteDialog(context, provider, recipe.id!),
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: CircularProgressIndicator()),
                  );

                  final Meal? fullMeal = await provider.fetchMealForDetail(recipe.mealId);
                  if (context.mounted) Navigator.pop(context); 

                  if (fullMeal != null && context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(meal: fullMeal),
                      ),
                    );
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(provider.error ?? 'Gagal membuka resep')),
                    );
                  }
                },
              );
              
            },
          );
        },
      ),
    );
  }
  void _showDeleteDialog(BuildContext context, MealProvider provider, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Favorit?'),
        content: const Text('Resep ini akan dihapus dari daftar favoritmu.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: const Text('Batal')
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await provider.deleteRecipe(id);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

}
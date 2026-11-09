import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (provider.isDbLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.savedRecipes.isEmpty) {
            return const Center(child: Text('Belum ada resep favorit.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.savedRecipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.savedRecipes[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(recipe.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                  ),
                  title: Text(recipe.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(recipe.note, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TOMBOL EDIT (UPDATE)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditDialog(context, provider, recipe.id!, recipe.note),
                      ),
                      //TOMBOL HAPUS (DELETE)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(context, provider, recipe.id!),
                      ),
                    ],
                  ),

                  
                ),
              );
            },
          );
        },
      ),
    );
  }
  void _showEditDialog(BuildContext context, MealProvider provider, int id, String currentNote) {
    final controller = TextEditingController(text: currentNote);
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Catatan'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Tulis catatan resep...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: const Text('Batal')
          ),
          ElevatedButton(
            onPressed: () async {
              await provider.updateNote(id, controller.text);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
  // FUNGSI DELETE (Dialog Konfirmasi Hapus)
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
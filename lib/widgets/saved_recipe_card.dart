import 'package:flutter/material.dart';
import '../models/saved_recipe.dart';

class SavedRecipeCard extends StatelessWidget {
  final SavedRecipe recipe;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SavedRecipeCard({
    super.key,
    required this.recipe,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            recipe.imageUrl, 
            width: 50, 
            height: 50, 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 70),
          ),
        ),
        title: Text(
          recipe.title, 
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          recipe.note.isEmpty ? 'Tidak ada catatan' : recipe.note, 
          maxLines: 2, 
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol Edit
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            // Tombol Hapus
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
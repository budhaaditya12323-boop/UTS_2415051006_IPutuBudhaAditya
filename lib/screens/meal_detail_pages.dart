import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../models/saved_recipe.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart'; 

class DetailScreen extends StatelessWidget {
  final Meal meal; 

  const DetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Resep
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul & Kategori
                  Text(
                    meal.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text('${meal.category} - ${meal.area}'),
                    backgroundColor: Colors.orange.shade100,
                  ),
                  const SizedBox(height: 24),

                  // Bahan-bahan
                  const Text(
                    'Bahan-bahan:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...meal.ingredients.map((ingredient) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: Colors.orange),
                            const SizedBox(width: 8),
                            Expanded(child: Text(ingredient)),
                          ],
                        ),
                      )),
                  
                  const SizedBox(height: 24),

                  // Instruksi
                  const Text(
                    'Cara Membuat:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.instructions,
                    style: const TextStyle(height: 1.5),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<MealProvider>(
                      builder: (context, provider, child) {
                        if (provider.isChecking) {
                          return const ElevatedButton(
                            onPressed: null,
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () async {
                            final saved = SavedRecipe(
                              mealId: meal.id,
                              title: meal.title,
                              imageUrl: meal.imageUrl,
                              note: 'Belum ada catatan',
                            );
                            
                            final String resultMessage = await context.read<MealProvider>().saveRecipe(saved);
                            
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(resultMessage),
                                  // Jika sukses (mengandung kata Berhasil), warna hijau. Jika sudah ada, warna orange.
                                  backgroundColor: resultMessage.contains('Berhasil') ? Colors.green : Colors.orange,
                                ),
                              );
                              
                              if (resultMessage.contains('Berhasil')) {
                                Navigator.pop(context);
                              }
                            }
                          },
                          icon: const Icon(Icons.favorite),
                          label: const Text('Simpan ke Favorit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
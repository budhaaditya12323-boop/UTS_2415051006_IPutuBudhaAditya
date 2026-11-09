import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';

class MealsTab extends StatelessWidget {
  const MealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test API')),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const Center(child: CircularProgressIndicator());
          if (provider.error != null) return Center(child: Text('Error: ${provider.error}'));
          
          return Column(
            children: [
              ElevatedButton(
                onPressed: () => provider.loadRandomMeals(),
                child: const Text('Load Random'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.meals.length,
                  itemBuilder: (context, index) {
                    final meal = provider.meals[index];
                    return ListTile(
                      leading: Image.network(meal.imageUrl, width: 50, fit: BoxFit.cover),
                      title: Text(meal.title),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
class Meal {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients; 

  Meal({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> tempIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        tempIngredients.add('${measure ?? ''} ${ingredient.trim()}'.trim());
      }
    }

    return Meal(
      id: json['idMeal'] as String? ?? '',
      title: json['strMeal'] as String? ?? 'Tanpa Judul',
      imageUrl: json['strMealThumb'] as String? ?? '',
      category: json['strCategory'] as String? ?? 'Unknown',
      area: json['strArea'] as String? ?? 'Unknown',
      instructions: json['strInstructions'] as String? ?? 'Tidak ada instruksi.',
      ingredients: tempIngredients,
    );
  }
}
class SavedRecipe {
  final int? id;
  final String mealId;
  final String title;
  final String imageUrl;
  final String note;

  SavedRecipe({
    this.id,
    required this.mealId,
    required this.title,
    required this.imageUrl,
    required this.note,
  });

  factory SavedRecipe.fromJson(Map<String, dynamic> json) {
    return SavedRecipe(
      id: json['id'] as int?,
      mealId: json['meal_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_id': mealId,
      'title': title,
      'image_url': imageUrl,
      'note': note,
    };
  }
}
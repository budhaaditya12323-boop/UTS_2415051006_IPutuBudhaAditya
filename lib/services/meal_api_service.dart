import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['meals'] == null) {
          return []; 
        }

        final List<dynamic> list = data['meals'];
        return list.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw Exception('Gagal terhubung ke server (HTTP ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error jaringan: $e');
    }
  }

  Future<List<Meal>> getRandomMeals() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['meals'];
        return list.map((json) => Meal.fromJson(json)).toList();
      }
      throw Exception('Gagal mengambil data acak');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Meal> getMealById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['meals'] == null) {
          throw Exception('Resep tidak ditemukan di server');
        }
        
        // API mengembalikan List, ambil index pertama
        final List<dynamic> list = data['meals'];
        return Meal.fromJson(list[0]);
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
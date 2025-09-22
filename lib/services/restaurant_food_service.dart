import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class RestaurantFoodService {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  // Get all foods
  static Future<List<FoodModel>> getAllFoods() async {
    try {
      print('Fetching all foods from API...');
      final response = await http.get(
        Uri.parse('$baseUrl/foods/get'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> foodList = data['data'];
          print('Food list length: ${foodList.length}');

          final foods = foodList.map((food) {
            print('Processing food: $food');
            final model = FoodModel.fromApiJson(food);
            print('Created food model: ${model.name} - ${model.price}');
            return model;
          }).toList();

          return foods;
        } else {
          throw Exception('API returned success: false or no data');
        }
      } else {
        print('API returned status code: ${response.statusCode}');
        throw Exception('Failed to load foods: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getAllFoods: $e');
      return getFallbackFoods();
    }
  }

  // Get foods by restaurant ID (filter from all foods)
  static Future<List<FoodModel>> getFoodsByRestaurantId(String restaurantId) async {
    try {
      final allFoods = await getAllFoods();
      return allFoods.where((food) => food.restaurantId == restaurantId).toList();
    } catch (e) {
      print('Exception in getFoodsByRestaurantId: $e');
      return getFallbackFoodsForRestaurant(restaurantId);
    }
  }

  // Get single food by ID
  static Future<FoodModel?> getFoodById(String id) async {
    try {
      print('Fetching food with ID: $id');
      final response = await http.get(
        Uri.parse('$baseUrl/foods/get/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          return FoodModel.fromApiJson(data['data']);
        } else {
          throw Exception('API returned success: false or no data');
        }
      } else {
        print('API returned status code: ${response.statusCode}');
        throw Exception('Failed to load food: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getFoodById: $e');
      return null;
    }
  }

  // Create new food
  static Future<FoodModel?> createFood(Map<String, dynamic> foodData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/foods/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(foodData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return FoodModel.fromApiJson(data['data'][0]);
        }
      }
      return null;
    } catch (e) {
      print('Exception in createFood: $e');
      return null;
    }
  }

  // Update food
  static Future<FoodModel?> updateFood(String id, Map<String, dynamic> foodData) async {
    try {
      final response = await http.post( // API uses POST for update
        Uri.parse('$baseUrl/foods/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(foodData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return FoodModel.fromApiJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      print('Exception in updateFood: $e');
      return null;
    }
  }

  // Delete food
  static Future<bool> deleteFood(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/foods/delete'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Exception in deleteFood: $e');
      return false;
    }
  }

  // Fallback foods when API is not available
  static List<FoodModel> getFallbackFoods() {
    return [
      FoodModel(
        id: '1',
        name: 'Chicken Bowl',
        price: '₹ 240',
        imagePath: 'assets/images/categories/food-2.png',
        description: 'Delicious chicken bowl',
        category: 'Chicken',
        rating: 4.2,
        reviews: 35,
        restaurant: 'Oh Yeah Chicken',
        deliveryTime: '25-30 mins',
        restaurantId: '1',
      ),
      FoodModel(
        id: '2',
        name: 'Grilled Chicken',
        price: '₹ 180',
        imagePath: 'assets/images/categories/food-1.png',
        description: 'Perfectly grilled chicken',
        category: 'Chicken',
        rating: 4.5,
        reviews: 42,
        restaurant: 'Oh Yeah Chicken',
        deliveryTime: '20-25 mins',
        restaurantId: '1',
      ),
    ];
  }

  // Fallback foods for specific restaurant
  static List<FoodModel> getFallbackFoodsForRestaurant(String restaurantId) {
    final foods = getFallbackFoods();
    return foods.where((food) => food.restaurantId == restaurantId).toList();
  }
}
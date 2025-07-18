import '../models/food_model.dart';

class FoodService {
  // Simulated API data - in real app, this would come from API
  static final List<FoodModel> _foods = [
    FoodModel(
      id: '1',
      name: 'Chicken Bowl',
      price: '₹ 240',
      imagePath: 'assets/images/categories/food-2.png',
      description: 'Delicious chicken bowl with fresh vegetables',
      category: 'Chicken',
      rating: 4.2,
      reviews: 54,
      restaurant: 'The Shark Restaurant',
      deliveryTime: '30-35 mins',
    ),
    FoodModel(
      id: '2',
      name: 'Grilled Chicken',
      price: '₹ 180',
      imagePath: 'assets/images/categories/food-1.png',
      description: 'Perfectly grilled chicken with herbs',
      category: 'Chicken',
      rating: 4.5,
      reviews: 32,
      restaurant: 'The Royal Paradise',
      deliveryTime: '25-30 mins',
    ),
    FoodModel(
      id: '3',
      name: 'Chicken Wings',
      price: '₹ 320',
      imagePath: 'assets/images/categories/food-3.jpg',
      description: 'Crispy chicken wings with special sauce',
      category: 'Chicken',
      rating: 4.0,
      reviews: 28,
      restaurant: 'The Shark Restaurant',
      deliveryTime: '20-25 mins',
    ),
    FoodModel(
      id: '4',
      name: 'Chicken Burger',
      price: '₹ 150',
      imagePath: 'assets/images/categories/chicken-2.png',
      description: 'Juicy chicken burger with fresh lettuce',
      category: 'Burger',
      rating: 4.3,
      reviews: 45,
      restaurant: 'The Royal Paradise',
      deliveryTime: '15-20 mins',
    ),
    FoodModel(
      id: '5',
      name: 'Chicken Pizza',
      price: '₹ 280',
      imagePath: 'assets/images/restruants/res-2.jpg',
      description: 'Delicious chicken pizza with cheese',
      category: 'Pizza',
      rating: 4.1,
      reviews: 38,
      restaurant: 'The Shark Restaurant',
      deliveryTime: '35-40 mins',
    ),
    FoodModel(
      id: '6',
      name: 'Chicken Sandwich',
      price: '₹ 120',
      imagePath: 'assets/images/categories/chicken-1.png',
      description: 'Fresh chicken sandwich with vegetables',
      category: 'Sandwich',
      rating: 4.4,
      reviews: 22,
      restaurant: 'The Royal Paradise',
      deliveryTime: '10-15 mins',
    ),
  ];

  // Get all foods
  static Future<List<FoodModel>> getAllFoods() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _foods;
  }

  // Get foods by category
  static Future<List<FoodModel>> getFoodsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _foods.where((food) => food.category == category).toList();
  }

  // Get food by ID
  static Future<FoodModel?> getFoodById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _foods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search foods
  static Future<List<FoodModel>> searchFoods(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowercaseQuery = query.toLowerCase();
    return _foods
        .where(
          (food) =>
              food.name.toLowerCase().contains(lowercaseQuery) ||
              food.description.toLowerCase().contains(lowercaseQuery) ||
              food.category.toLowerCase().contains(lowercaseQuery),
        )
        .toList();
  }

  // Get hot deals (foods with high rating)
  static Future<List<FoodModel>> getHotDeals() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _foods.where((food) => food.rating >= 4.0).toList();
  }

  // Get recommended foods
  static Future<List<FoodModel>> getRecommendedFoods() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _foods.take(4).toList(); // Return first 4 items as recommended
  }
}

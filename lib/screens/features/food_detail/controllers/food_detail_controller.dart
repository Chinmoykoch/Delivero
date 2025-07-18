import 'package:get/get.dart';
import '../../../../models/food_model.dart';
import '../../../../services/food_service.dart';

class FoodDetailController extends GetxController {
  final Rx<FoodModel?> selectedFood = Rx<FoodModel?>(null);
  final RxList<FoodModel> recommendedFoods = <FoodModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Load food details by ID
  Future<void> loadFoodDetails(String foodId) async {
    isLoading.value = true;
    try {
      final food = await FoodService.getFoodById(foodId);
      selectedFood.value = food;

      if (food != null) {
        await loadRecommendedFoods();
      }
    } catch (e) {
      print('Error loading food details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load recommended foods
  Future<void> loadRecommendedFoods() async {
    try {
      final foods = await FoodService.getAllFoods();
      // Filter out the current food and take first 6
      final filteredFoods =
          foods
              .where((food) => food.id != selectedFood.value?.id)
              .take(6)
              .toList();
      recommendedFoods.assignAll(filteredFoods);
    } catch (e) {
      print('Error loading recommended foods: $e');
    }
  }

  // Get food by index (for grid view)
  FoodModel? getFoodByIndex(int index) {
    if (index < recommendedFoods.length) {
      return recommendedFoods[index];
    }
    return null;
  }

  // Toggle favorite
  void toggleFavorite() {
    if (selectedFood.value != null) {
      // In a real app, you would update the favorite status in the database
      Get.snackbar(
        'Favorite',
        selectedFood.value!.name + ' added to favorites',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Get restaurant info
  Map<String, String> getRestaurantInfo() {
    if (selectedFood.value != null) {
      return {
        'name': selectedFood.value!.restaurant,
        'deliveryTime': selectedFood.value!.deliveryTime,
        'rating': selectedFood.value!.rating.toString(),
        'reviews': selectedFood.value!.reviews.toString(),
      };
    }
    return {
      'name': 'Restaurant Name',
      'deliveryTime': '30-35 mins',
      'rating': '4.5',
      'reviews': '100',
    };
  }

  // Search in restaurant
  void searchInRestaurant(String query) {
    if (query.isEmpty) return;

    Get.snackbar(
      'Search',
      'Searching for: $query',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}

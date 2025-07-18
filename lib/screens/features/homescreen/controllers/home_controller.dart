import 'package:get/get.dart';
import '../../../../models/food_model.dart';
import '../../../../services/food_service.dart';

class HomeController extends GetxController {
  final RxList<FoodModel> hotDeals = <FoodModel>[].obs;
  final RxList<FoodModel> recommendedFoods = <FoodModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadHotDeals();
    loadRecommendedFoods();
  }

  // Load hot deals
  Future<void> loadHotDeals() async {
    isLoading.value = true;
    try {
      final foods = await FoodService.getHotDeals();
      hotDeals.assignAll(foods);
    } catch (e) {
      print('Error loading hot deals: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load recommended foods
  Future<void> loadRecommendedFoods() async {
    try {
      final foods = await FoodService.getRecommendedFoods();
      recommendedFoods.assignAll(foods);
    } catch (e) {
      print('Error loading recommended foods: $e');
    }
  }

  // Search foods
  Future<List<FoodModel>> searchFoods(String query) async {
    if (query.isEmpty) return [];

    try {
      return await FoodService.searchFoods(query);
    } catch (e) {
      print('Error searching foods: $e');
      return [];
    }
  }

  // Get foods by category
  Future<List<FoodModel>> getFoodsByCategory(String category) async {
    if (category == 'All') {
      return await FoodService.getAllFoods();
    }

    try {
      return await FoodService.getFoodsByCategory(category);
    } catch (e) {
      print('Error getting foods by category: $e');
      return [];
    }
  }

  // Set selected category
  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  // Refresh data
  Future<void> refreshData() async {
    await Future.wait([loadHotDeals(), loadRecommendedFoods()]);
  }
}

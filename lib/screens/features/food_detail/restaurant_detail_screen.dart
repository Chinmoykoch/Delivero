import 'package:delivero/screens/features/food_detail/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/food_model.dart';
import '../../../services/restaurant_food_service.dart';
import '../dine-in/models/restaurant-models.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final RestaurantModel? restaurant;
  
  const RestaurantDetailScreen({super.key, this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  List<FoodModel> foods = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      List<FoodModel> loadedFoods = [];
      
      if (widget.restaurant?.id != null) {
        // Try to load foods for this specific restaurant
        loadedFoods = await RestaurantFoodService.getFoodsByRestaurantId(widget.restaurant!.id);
      }
      
      // If no foods found for restaurant or no restaurant specified, load fallback foods
      if (loadedFoods.isEmpty) {
        loadedFoods = RestaurantFoodService.getFallbackFoods();
      }

      setState(() {
        foods = loadedFoods;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load foods: $e';
        isLoading = false;
        foods = RestaurantFoodService.getFallbackFoods();
      });
      print('Error loading foods: $e');
    }
  }

  // Get restaurant data (either from parameter or fallback)
  RestaurantModel get restaurantData {
    return widget.restaurant ?? RestaurantModel(
      id: 'fallback',
      name: 'Oh Yeah Chicken',
      logoUrl: 'assets/images/restruants/chicken-logo.png',
      bannerUrl: 'assets/images/restruants/res-2.jpg',
      lat: 26.1445,
      lng: 91.7362,
      address: '69c Jalukbari, Guwahati',
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = restaurantData;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none, // Allows overflow for the circular image
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: restaurant.bannerUrl != null && restaurant.bannerUrl!.startsWith('http')
                      ? Image.network(
                          restaurant.bannerUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading banner image: $error');
                            return _buildFallbackBanner();
                          },
                        )
                      : _buildFallbackBanner(),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10,
                        ),
                        child: Icon(Icons.arrow_back, size: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Color(0xFF00936D),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  bottom: -55,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: restaurant.logoUrl != null && restaurant.logoUrl!.startsWith('http')
                          ? ClipOval(
                              child: Image.network(
                                restaurant.logoUrl!,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading logo: $error');
                                  return _buildFallbackLogo();
                                },
                              ),
                            )
                          : _buildFallbackLogo(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        restaurant.name,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    restaurant.address.isNotEmpty ? restaurant.address : "69c Jalukbari, Guwahati",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.delivery_dining,
                        color: Color(0xFF00936D),
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Free Delivery",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.timer, color: Color(0xFF00936D), size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "15-20 mins",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12, width: 0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.black38, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            "Search for ${restaurant.name.toLowerCase()}'s speciality",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Recommended for you",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Display loading, error or foods
                  if (isLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (errorMessage.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.grey),
                            const SizedBox(height: 8),
                            Text(
                              errorMessage,
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _loadFoods,
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (foods.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No foods available for this restaurant',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return RestaurantFoodCard(food: foods[index]);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackBanner() {
    return Image.asset(
      "assets/images/restruants/res-2.jpg",
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading fallback banner: $error');
        return Container(
          width: double.infinity,
          height: 250,
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant, color: Colors.grey[600], size: 50),
              const SizedBox(height: 8),
              Text(
                'Restaurant Image',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFallbackLogo() {
    return Image.asset(
      'assets/images/restruants/chicken-logo.png',
      width: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading fallback logo: $error');
        return Icon(
          Icons.restaurant,
          color: Colors.grey[600],
          size: 40,
        );
      },
    );
  }
}
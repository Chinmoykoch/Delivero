import 'package:delivero/screens/features/food_detail/food_detail_screen.dart';
import 'package:delivero/screens/features/food_detail/restaurant_detail_screen.dart';
import 'package:delivero/screens/features/homescreen/widgets/homescreen_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dine-in/models/restaurant-models.dart';
import '../../dine-in/service/restaurant-service.dart';

List<Map<String, String>> categories = [
  {"image": "assets/images/categories/burger.png", "name": "Burgers"},
  {"image": "assets/images/categories/pizza.png", "name": "Pizza"},
  {"image": "assets/images/categories/fries.png", "name": "Fries"},
  {"image": "assets/images/categories/soft-drink.png", "name": "Soft-Drink"},
];

List<Map<String, String>> hotDeals = [
  {
    "image": "assets/images/categories/chicken-2.png",
    "rating": "4.1",
    "reviews": "50",
    "name": "Crispy Parmesan-Crusted Chicken with Garlic-Herb Butter",
    "restaurant": "The Shark Restaurant",
    "time": "30-35 mins",
  },
  {
    "image": "assets/images/categories/🖼 Import image (2).png",
    "rating": "4.8",
    "reviews": "23",
    "name": "Crispy Parmesan-Crusted Chicken with Garlic-Herb Butter",
    "restaurant": "KFC Maligaon",
    "time": "30-35 mins",
  },
  {
    "image": "assets/images/categories/🖼 Import image (9).png",
    "rating": "4.8",
    "reviews": "48",
    "name": "Crispy Parmesan-Crusted Chicken with Garlic-Herb Butter",
    "restaurant": "Burger King Adabari",
    "time": "25 mins",
  },
];

List<Map<String, String>> recommended = [
  {
    "restautantimage": "assets/images/categories/chicken-1.png",
    "restautanttime": "40-45 mins",
    "name": "The Royal Paradise",
    "restautantrating": "4.2",
    "restautantreviews": "35",
  },
  {
    "restautantimage": "assets/images/categories/chicken-2.png",
    "restautanttime": "35-40 mins",
    "name": "Foodie's Paradise",
    "restautantrating": "4.5",
    "restautantreviews": "54",
  },
  {
    "restautantimage": "assets/images/categories/food-2.png",
    "restautanttime": "30 mins",
    "name": "The Royal Awas",
    "restautantrating": "4.2",
    "restautantreviews": "50",
  },
  {
    "restautantimage": "assets/images/restruants/res-1.png",
    "restautanttime": "45 mins",
    "name": "The North Kitchen",
    "restautantrating": "4.2",
    "restautantreviews": "35",
  },
  {
    "restautantimage": "assets/images/restruants/res-2.jpg",
    "restautanttime": "35-40 mins",
    "name": "Elaichi",
    "restautantrating": "4.5",
    "restautantreviews": "35",
  },
];

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<RestaurantModel> restaurants = [];
  bool isLoadingRestaurants = false;
  String restaurantError = '';

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      setState(() {
        isLoadingRestaurants = true;
        restaurantError = '';
      });

      final loadedRestaurants = await RestaurantApiService.getAllRestaurants();
      
      setState(() {
        restaurants = loadedRestaurants;
        isLoadingRestaurants = false;
      });
    } catch (e) {
      setState(() {
        restaurantError = 'Failed to load restaurants: $e';
        isLoadingRestaurants = false;
        restaurants = RestaurantApiService.getFallbackRestaurants();
      });
      print('Error loading restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Column(
        children: [
          // Fixed header at the top
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: HomeScreenHeader(),
            ),
          ),
          // Scrollable content below header
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hey",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Chinmoy,",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "What are you going to eat today ?",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black38),
                              const SizedBox(width: 5),
                              Text(
                                "Search Dishes ...",
                                style: TextStyle(color: Colors.black26),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 16),
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => Categories(
                              image: categories[index]["image"]!,
                              name: categories[index]["name"]!,
                            ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hot Deals",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "See All",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF00936D),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFF00936D),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 16),
                        itemCount: hotDeals.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap: () {
                                Get.to(() => const FoodDetailScreen());
                              },
                              child: HotDealsCard(
                                image: hotDeals[index]["image"]!,
                                rating: hotDeals[index]["rating"]!,
                                reviews: hotDeals[index]["reviews"]!,
                                name: hotDeals[index]["name"]!,
                                restaurant: hotDeals[index]["restaurant"]!,
                                time: hotDeals[index]["time"]!,
                              ),
                            ),
                      ),
                    ),

                    // const SizedBox(height: 16),
                    // Text(
                    //   "Explore Food Types",
                    //   style: GoogleFonts.montserrat(
                    //     textStyle: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 12),
                    // Row(
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(color: Colors.grey),
                    //       child: Row(
                    //         children: [
                    //           Icon(Icons.free_breakfast),
                    //           const SizedBox(width: 8),
                    //           Text(
                    //             "Breakfast",
                    //             style: GoogleFonts.montserrat(
                    //               textStyle: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(color: Colors.grey),
                    //       child: Row(
                    //         children: [
                    //           Icon(Icons.free_breakfast),
                    //           const SizedBox(width: 8),
                    //           Text(
                    //             "Breakfast",
                    //             style: GoogleFonts.montserrat(
                    //               textStyle: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 16),
                    Text(
                      "Special Promo this week",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 170,
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: banners.length,
                        itemBuilder:
                            (context, index) => Banners(image: banners[index]),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Recommeded for you",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Restaurant Cards Section
                    if (isLoadingRestaurants)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (restaurantError.isNotEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(Icons.error_outline, size: 48, color: Colors.grey),
                              const SizedBox(height: 8),
                              Text(
                                restaurantError,
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _loadRestaurants,
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Column(
                        children: restaurants.map((restaurant) => 
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => RestaurantDetailScreen(restaurant: restaurant));
                              },
                              child: RestaurantCardApi(
                                restaurant: restaurant,
                                // Keep static data for UI consistency
                                restautantrating: "4.2",
                                restautantreviews: "35",
                                restautanttime: "30-35 mins",
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                  ], // <-- closes children of inner Column
                ), // <-- closes inner Column
              ), // <-- closes Padding
            ), // <-- closes SingleChildScrollView
          ), // <-- closes Expanded
        ], // <-- closes children of outer Column
      ), // <-- closes outer Column
    ); // <-- closes Scaffold
  }
}

class ResturantCard extends StatelessWidget {
  const ResturantCard({
    super.key,
    required this.name,
    required this.restautantrating,
    required this.restautantreviews,
    required this.restautanttime,
    required this.restautantimage,
  });

  final String name,
      restautantrating,
      restautantreviews,
      restautanttime,
      restautantimage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                // ✅ Fixed this line
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.asset(
                restautantimage,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular((8)),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: Color(0xFF00936D),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 136,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        restautanttime,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.delivery_dining,
                        size: 20,
                        color: Color(0xFF00936D),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Text(
          name,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),

        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 8),
            Text(
              restautantrating,
              style: TextStyle(fontSize: 12, color: Colors.amber),
            ),
            const SizedBox(width: 8),
            Text(
              "($restautantreviews reviews)",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}

final List<String> banners = [
  "assets/images/banners/banner_5.jpg",
  "assets/images/banners/banner_2.jpg",
  "assets/images/banners/banner_6.jpg",
];

class Banners extends StatelessWidget {
  const Banners({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: Image.asset(image, height: 170, width: 300),
    );
  }
}

final List<String> foods = [
  "assets/images/banners/banner_5.jpg",
  "assets/images/banners/banner_2.jpg",
  "assets/images/banners/banner_6.jpg",
];

class HotDealsCard extends StatelessWidget {
  const HotDealsCard({
    super.key,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.name,
    required this.restaurant,
    required this.time,
  });
  final String image, rating, reviews, name, restaurant, time;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      // height: MediaQuery.of(context).size.height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF00936D),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Recommended",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.favorite, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 2),
              Text(rating, style: TextStyle(fontSize: 12, color: Colors.amber)),
              const SizedBox(width: 2),
              Text(
                "($reviews reviews)",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                time,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00936D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key, required this.image, required this.name});

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(child: Image.asset(image, fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// New RestaurantCard widget that works with API data
class RestaurantCardApi extends StatelessWidget {
  const RestaurantCardApi({
    super.key,
    required this.restaurant,
    required this.restautantrating,
    required this.restautantreviews,
    required this.restautanttime,
  });

  final RestaurantModel restaurant;
  final String restautantrating, restautantreviews, restautanttime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: restaurant.img_url.isNotEmpty && restaurant.img_url.startsWith('http')
                  ? Image.network(
                      restaurant.img_url,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.18,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.18,
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
                        print('Error loading restaurant image: $error');
                        return _buildFallbackImage(context);
                      },
                    )
                  : _buildFallbackImage(context),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: Color(0xFF00936D),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 136,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        restautanttime,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.delivery_dining,
                        size: 20,
                        color: Color(0xFF00936D),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          restaurant.name,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 8),
            Text(
              restautantrating,
              style: TextStyle(fontSize: 12, color: Colors.amber),
            ),
            const SizedBox(width: 8),
            Text(
              "($restautantreviews reviews)",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFallbackImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.18,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: 50,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 8),
          Text(
            restaurant.name,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
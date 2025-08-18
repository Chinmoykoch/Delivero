import 'package:delivero/screens/features/food_detail/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/food_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    "assets/images/restruants/res-2.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                        child: Icon(Icons.error, color: Colors.red, size: 50),
                      );
                    },
                  ),
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
                      child: Image.asset(
                        'assets/images/restruants/chicken-logo.png',
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading logo: $error');
                          return Icon(
                            Icons.restaurant,
                            color: Colors.grey[600],
                            size: 40,
                          );
                        },
                      ),
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
                        "Oh Yeah Chicken ",
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
                    "69c Jalukbari, Guwahati",
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
                            "Search for oh yeah chicken's speciality",
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

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final food = _getFoodByIndex(index);
                      if (food != null) {
                        return RestaurantFoodCard(food: food);
                      }
                      return const SizedBox.shrink();
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

  String _getFoodName(int index) {
    final foodNames = [
      "Chicken Bowl",
      "Grilled Chicken",
      "Chicken Wings",
      "Chicken Burger",
      "Chicken Pizza",
      "Chicken Sandwich",
    ];
    return foodNames[index % foodNames.length];
  }

  String _getFoodPrice(int index) {
    final prices = ["₹ 240", "₹ 180", "₹ 320", "₹ 150", "₹ 280", "₹ 120"];
    return prices[index % prices.length];
  }

  String _getFoodImage(int index) {
    final images = [
      "assets/images/categories/food-2.png",
      "assets/images/categories/food-1.png",
      "assets/images/categories/food-3.jpg",
      "assets/images/categories/chicken-2.png",
      "assets/images/restruants/res-2.jpg",
      "assets/images/categories/chicken-1.png",
    ];
    return images[index % images.length];
  }

  FoodModel? _getFoodByIndex(int index) {
    final foodNames = [
      "Chicken Bowl",
      "Grilled Chicken",
      "Chicken Wings",
      "Chicken Burger",
      "Chicken Pizza",
      "Chicken Sandwich",
    ];
    final prices = ["₹ 240", "₹ 180", "₹ 320", "₹ 150", "₹ 280", "₹ 120"];
    final images = [
      "assets/images/categories/food-2.png",
      "assets/images/categories/food-1.png",
      "assets/images/categories/food-3.jpg",
      "assets/images/categories/chicken-2.png",
      "assets/images/restruants/res-2.jpg",
      "assets/images/categories/chicken-1.png",
    ];

    if (index < foodNames.length) {
      return FoodModel(
        id: (index + 1).toString(),
        name: foodNames[index],
        price: prices[index],
        imagePath: images[index],
        description: "Delicious ${foodNames[index].toLowerCase()}",
        category: "Chicken",
        rating: 4.0 + (index * 0.1),
        reviews: 20 + (index * 10),
        restaurant: "The Shark Restaurant",
        deliveryTime: "30-35 mins",
      );
    }
    return null;
  }
}



//  Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total Amount:',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         '₹ ${cartController.getCartTotal().toStringAsFixed(0)}',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF00936D),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       // onPressed: () {
//                       //   cartController.proceedToCheckout();
//                       // },
//                       onPressed: () => Get.to(() => LoginScreen()),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF00936D),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         'Proceed to Checkout',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
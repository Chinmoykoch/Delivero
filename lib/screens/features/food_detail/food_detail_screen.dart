import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Map<String, String>> addons = [
  {"image": "assets/images/categories/fries.png", "name": "Fries"},
  {"image": "assets/images/categories/soft-drink.png", "name": "Pepsi"},
];

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(backgroundColor: Color(0xFFF7F7F7)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KFC Buckets",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "Meal for 2",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "4.8",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),

                                Text(
                                  "54 reviews",
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
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Calories",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "365 cal",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Protein",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "33 g",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(), // pushes image to the right
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/categories/kfc.png",
                          height: 160, // Increased from 180
                          width: 200, // Increased from 230
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading import image: $error');
                            return Container(
                              height: 160,
                              width: 220,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining_sharp,
                                  color: Color(0xFF00936D),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Free delivery",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Color(0xFF00936D),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "30 mins",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "4.8",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),

                                Text(
                                  "ratings",
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Description",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "This meal features a delicious variety of KFC's signature chicken—crispy on the outside, juicy on the inside, and seasoned with a secret blend of 11 herbs and spices. Served with flavorful sides like buttery corn, creamy mashed potatoes, or crispy fries, it’s a perfect combo for two hungry food lovers craving comfort and crunch.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Select addons",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  SizedBox(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: addons.length,
                        itemBuilder: (context, index) {
                          return Addons(
                            image: addons[index]["image"]!,
                            name: addons[index]["name"]!,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '₹ 500',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00936D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: () {
                    //   cartController.proceedToCheckout();
                    // },
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00936D),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Proceed to Checkout',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Addons extends StatelessWidget {
  const Addons({super.key, required this.image, required this.name});

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 80,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading food-1 image: $error');
                    return Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                        size: 30,
                      ),
                    );
                  },
                ),

                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 0.8),

                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

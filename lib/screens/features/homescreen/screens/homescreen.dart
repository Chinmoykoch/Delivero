import 'package:delivero/screens/features/food_detail/food_detail_screen.dart';
import 'package:delivero/screens/features/homescreen/widgets/homescreen_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("All Categories", style: TextStyle(fontSize: 18)),
                    //     Row(
                    //       children: [
                    //         Text("See All", style: TextStyle(fontSize: 16)),
                    //         const SizedBox(width: 5),
                    //         Icon(Icons.arrow_forward_ios, size: 16),
                    //       ],
                    //     ),
                    //   ],
                    //),
                    Row(
                      children: [
                        Categories(),
                        const SizedBox(width: 10),
                        Categories2(key: key),
                      ],
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
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap: () {
                                Get.to(() => const FoodDetailScreen());
                              },
                              child: HotDealsCard(
                                image:
                                    "assets/images/categories/🖼 Import image (2).png",
                                rating: "4.2",
                                reviews: "54",
                                name:
                                    "Crispy Parmesan-Crusted Chicken with Garlic-Herb Butter",
                                restaurant: "The Shark Restaurant",
                                time: "30-35 mins",
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
                    Column(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ResturantCard(
                            restautantimage:
                                "assets/images/categories/chicken-2.png",
                            restautanttime: "35-40 mins",
                            name: "The Royal Paradise",
                            restautantrating: "4.5",
                            restautantreviews: "54",
                          ),
                        ),
                      ),
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
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF00936D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/categories/burger.png",

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "Hamburgers",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class Categories2 extends StatelessWidget {
  const Categories2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 110, 110, 110),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/categories/pizza.png",

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "Pizza",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

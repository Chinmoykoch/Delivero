import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/restaurant-models.dart';

class ResCard extends StatelessWidget {
  const ResCard({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .92,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child:
                restaurant.img_url.isNotEmpty
                    ? Image.network(
                      restaurant.img_url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                              color: Color(0xFF00936D),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print(
                          'Network image error for ${restaurant.name}: $error',
                        );
                        // Fallback to local asset
                        return Image.asset(
                          "assets/images/restruants/res-4.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print(
                              'Local asset error for ${restaurant.name}: $error',
                            );
                            return Container(
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restaurant,
                                    size: 50,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image not available',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                    : Image.asset(
                      "assets/images/restruants/res-4.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(
                          'Local asset error for ${restaurant.name}: $error',
                        );
                        return Container(
                          color: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Image not available',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.address,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amberAccent, size: 16),
                        SizedBox(width: 5),
                        Text(
                          restaurant.rating.toString(),
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(color: Colors.black12, thickness: 1),

                Row(
                  children: [
                    Icon(Icons.near_me, color: Color(0xFF00936D), size: 16),
                    SizedBox(width: 5),
                    Text(
                      restaurant.distance,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

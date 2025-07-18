import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../models/food_model.dart';
import '../../../../controllers/cart_controller.dart';

class RestaurantFoodCard extends StatefulWidget {
  final FoodModel food;

  const RestaurantFoodCard({super.key, required this.food});

  @override
  State<RestaurantFoodCard> createState() => _RestaurantFoodCardState();
}

class _RestaurantFoodCardState extends State<RestaurantFoodCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: Image.asset(widget.food.imagePath, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 75,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  int modalQuantity = quantity;
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Drag handle
                                Container(
                                  width: 40,
                                  height: 4,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),

                                // Food Info
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        widget.food.imagePath,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.food.name,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            widget.food.price,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF00936D),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                // Quantity & Add Button
                                Row(
                                  children: [
                                    // Quantity Selector
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color:
                                                  modalQuantity > 0
                                                      ? const Color(0xFF00936D)
                                                      : Colors.grey[400],
                                            ),
                                            onPressed: () {
                                              if (modalQuantity > 0) {
                                                setModalState(
                                                  () => modalQuantity--,
                                                );
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              modalQuantity.toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              color: Color(0xFF00936D),
                                            ),
                                            onPressed: () {
                                              setModalState(
                                                () => modalQuantity++,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    // Add to Cart Button
                                    Expanded(
                                      child: GestureDetector(
                                        onTap:
                                            modalQuantity > 0
                                                ? () {
                                                  setState(
                                                    () =>
                                                        quantity =
                                                            modalQuantity,
                                                  );
                                                  Navigator.pop(context);

                                                  // Add to cart using controller
                                                  final cartController =
                                                      Get.find<
                                                        CartController
                                                      >();
                                                  cartController.addToCart(
                                                    widget.food,
                                                    modalQuantity,
                                                  );
                                                }
                                                : null,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color:
                                                modalQuantity > 0
                                                    ? const Color(0xFF00936D)
                                                    : Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Add to Cart',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    modalQuantity > 0
                                                        ? Colors.white
                                                        : Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.add, color: Color(0xFF00936D), size: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          widget.food.name,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),

        Text(
          widget.food.price,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00936D),
            ),
          ),
        ),
      ],
    );
  }
}

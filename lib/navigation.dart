import 'package:delivero/screens/features/dine-in/screens/dine_in.dart';
import 'package:delivero/screens/features/homescreen/screens/homescreen.dart';
import 'package:delivero/screens/features/orders/screens/orders.dart';
import 'package:delivero/screens/features/profile/screens/profile.dart';
import 'package:delivero/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final cartController = Get.find<CartController>();

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 75,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: const Color(0xFFF7F7F7),
          indicatorColor: Color(0xFF00936D),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            const NavigationDestination(
              icon: Icon(Icons.delivery_dining),
              label: 'Orders',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_sharp),
              label: 'Dine In',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (cartController.isCartEmpty()) {
          return const SizedBox.shrink();
        }
        return FloatingActionButton(
          onPressed: () {
            cartController.showCartSnackbarAgain();
          },
          backgroundColor: const Color(0xFF00936D),
          child: Stack(
            children: [
              const Icon(Icons.shopping_cart, color: Colors.white),
              if (cartController.getCartItemCount() > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartController.getCartItemCount().toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Homescreen(),
    const OrderScreen(),
    const DineInScreen(),
    const ProfileScreen(),
  ];
}

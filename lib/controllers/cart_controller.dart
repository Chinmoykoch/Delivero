import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/food_model.dart';
import '../services/cart_service.dart';
import '../screens/features/cart/screens/cart_screen.dart';

class CartController extends GetxController {
  final Rx<CartModel> cart = CartModel().obs;
  final RxBool isLoading = false.obs;
  final RxBool showCartSnackbar = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  // Load cart from storage
  void loadCart() {
    CartService.loadCartFromStorage();
    cart.value = CartService.getCart();
  }

  // Add item to cart
  void addToCart(FoodModel food, int quantity) {
    try {
      final updatedCart = CartService.addToCart(food, quantity);
      cart.value = updatedCart;

      // Show persistent cart snackbar
      showCartSnackbar.value = true;
      _showCartSnackbar();
    } catch (e) {
      print('Error adding item to cart: $e');
      Get.snackbar(
        'Error',
        'Failed to add item to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Show cart snackbar
  void _showCartSnackbar() {
    try {
      if (showCartSnackbar.value && !isCartEmpty()) {
        // Close any existing snackbars first
        Get.closeCurrentSnackbar();

        Get.snackbar(
          '',
          '',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xFF00936D),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          messageText: Row(
            children: [
              const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${getCartItemCount()} items in cart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back(); // Close snackbar
                  Get.to(() => const CartScreen());
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'View Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          titleText: const SizedBox.shrink(),
          onTap: (_) {
            Get.back(); // Close snackbar
            Get.to(() => const CartScreen());
          },
        );
      }
    } catch (e) {
      print('Error showing cart snackbar: $e');
    }
  }

  // Remove item from cart
  void removeFromCart(String foodId) {
    try {
      final updatedCart = CartService.removeFromCart(foodId);
      cart.value = updatedCart;

      // Hide cart snackbar if cart is now empty
      if (updatedCart.isEmpty) {
        hideCartSnackbar();
      }

      Get.snackbar(
        'Removed',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error removing item from cart: $e');
      Get.snackbar(
        'Error',
        'Failed to remove item from cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Update item quantity
  void updateQuantity(String foodId, int quantity) {
    try {
      final updatedCart = CartService.updateQuantity(foodId, quantity);
      cart.value = updatedCart;

      // Hide cart snackbar if cart is now empty
      if (updatedCart.isEmpty) {
        hideCartSnackbar();
      }
    } catch (e) {
      print('Error updating item quantity: $e');
      Get.snackbar(
        'Error',
        'Failed to update item quantity',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Clear cart
  void clearCart() {
    try {
      final updatedCart = CartService.clearCart();
      cart.value = updatedCart;

      // Hide cart snackbar when cart is cleared
      hideCartSnackbar();

      Get.snackbar(
        'Cart Cleared',
        'All items removed from cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error clearing cart: $e');
      Get.snackbar(
        'Error',
        'Failed to clear cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Get cart total
  double getCartTotal() {
    return cart.value.totalAmount;
  }

  // Get cart item count
  int getCartItemCount() {
    return cart.value.totalItems;
  }

  // Check if cart is empty
  bool isCartEmpty() {
    return cart.value.isEmpty;
  }

  // Get cart items
  List<CartItemModel> getCartItems() {
    return cart.value.items;
  }

  // Check if item exists in cart
  bool isItemInCart(String foodId) {
    return CartService.isItemInCart(foodId);
  }

  // Get item quantity in cart
  int getItemQuantity(String foodId) {
    return CartService.getItemQuantity(foodId);
  }

  // Proceed to checkout
  void proceedToCheckout() {
    if (isCartEmpty()) {
      Get.snackbar(
        'Empty Cart',
        'Please add items to cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Navigate to checkout page
    // Get.to(() => CheckoutScreen());
    Get.snackbar(
      'Checkout',
      'Proceeding to checkout...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Show cart snackbar if items exist
  void showCartSnackbarIfItemsExist() {
    if (!isCartEmpty() && showCartSnackbar.value) {
      _showCartSnackbar();
    }
  }

  // Hide cart snackbar
  void hideCartSnackbar() {
    try {
      showCartSnackbar.value = false;
      Get.closeCurrentSnackbar();
    } catch (e) {
      print('Error hiding cart snackbar: $e');
    }
  }

  // Show cart snackbar again (for when user dismisses it but cart still has items)
  void showCartSnackbarAgain() {
    try {
      if (!isCartEmpty()) {
        showCartSnackbar.value = true;
        _showCartSnackbar();
      }
    } catch (e) {
      print('Error showing cart snackbar again: $e');
    }
  }
}

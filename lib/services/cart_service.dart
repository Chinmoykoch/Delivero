import '../models/cart_model.dart';
import '../models/food_model.dart';

class CartService {
  static CartModel _cart = CartModel();

  // Get current cart
  static CartModel getCart() {
    return _cart;
  }

  // Add item to cart
  static CartModel addToCart(FoodModel food, int quantity) {
    _cart = _cart.addItem(food, quantity);
    _saveCartToStorage();
    return _cart;
  }

  // Remove item from cart
  static CartModel removeFromCart(String foodId) {
    _cart = _cart.removeItem(foodId);
    _saveCartToStorage();
    return _cart;
  }

  // Update item quantity
  static CartModel updateQuantity(String foodId, int quantity) {
    _cart = _cart.updateQuantity(foodId, quantity);
    _saveCartToStorage();
    return _cart;
  }

  // Clear cart
  static CartModel clearCart() {
    _cart = _cart.clear();
    _saveCartToStorage();
    return _cart;
  }

  // Get cart total
  static double getCartTotal() {
    return _cart.totalAmount;
  }

  // Get cart item count
  static int getCartItemCount() {
    return _cart.totalItems;
  }

  // Check if cart is empty
  static bool isCartEmpty() {
    return _cart.isEmpty;
  }

  // Get cart items
  static List<CartItemModel> getCartItems() {
    return _cart.items;
  }

  // Check if item exists in cart
  static bool isItemInCart(String foodId) {
    return _cart.items.any((item) => item.food.id == foodId);
  }

  // Get item quantity in cart
  static int getItemQuantity(String foodId) {
    final item = _cart.items.firstWhere(
      (item) => item.food.id == foodId,
      orElse:
          () => CartItemModel(
            food: FoodModel(
              id: '',
              name: '',
              price: '',
              imagePath: '',
              description: '',
              category: '',
              rating: 0.0,
              reviews: 0,
              restaurant: '',
              deliveryTime: '',
            ),
            quantity: 0,
          ),
    );
    return item.quantity;
  }

  // Simulate saving cart to local storage
  static void _saveCartToStorage() {
    // In a real app, you would save to SharedPreferences or local database
    print('Cart saved to storage: ${_cart.toJson()}');
  }

  // Simulate loading cart from local storage
  static void loadCartFromStorage() {
    // In a real app, you would load from SharedPreferences or local database
    // For now, we'll keep the cart in memory
    print('Cart loaded from storage');
  }
}

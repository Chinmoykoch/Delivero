class AppConstants {
  // App Colors
  static const int primaryColor = 0xFF00936D;
  static const int secondaryColor = 0xFFF7F7F7;
  static const int backgroundColor = 0xFFFFFFFF;
  static const int textColor = 0xFF000000;
  static const int textLightColor = 0xFF666666;
  static const int borderColor = 0xFFE0E0E0;

  // App Dimensions
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // App Text Sizes
  static const double smallTextSize = 12.0;
  static const double mediumTextSize = 14.0;
  static const double largeTextSize = 16.0;
  static const double extraLargeTextSize = 18.0;
  static const double titleTextSize = 20.0;

  // App Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // App Strings
  static const String appName = 'Delivero';
  static const String appVersion = '1.0.0';
  static const String currency = '₹';

  // Navigation Labels
  static const String homeLabel = 'Home';
  static const String ordersLabel = 'Orders';
  static const String dineInLabel = 'Dine In';
  static const String profileLabel = 'Profile';
  static const String cartLabel = 'My Cart';

  // Food Categories
  static const List<String> foodCategories = [
    'All',
    'Chicken',
    'Burger',
    'Pizza',
    'Sandwich',
    'Dessert',
    'Beverages',
  ];

  // Error Messages
  static const String networkError =
      'Network error occurred. Please try again.';
  static const String generalError = 'Something went wrong. Please try again.';
  static const String emptyCartMessage = 'Your cart is empty.';
  static const String addToCartSuccess = 'Item added to cart successfully.';
  static const String removeFromCartSuccess = 'Item removed from cart.';

  // Success Messages
  static const String orderPlacedSuccess = 'Order placed successfully!';
  static const String profileUpdatedSuccess = 'Profile updated successfully!';
  static const String cartClearedSuccess = 'Cart cleared successfully!';

  // Validation Messages
  static const String requiredField = 'This field is required.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String passwordTooShort =
      'Password must be at least 6 characters.';

  // API Endpoints (for future use)
  static const String baseUrl = 'https://api.delivero.com';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String foodsEndpoint = '/foods';
  static const String ordersEndpoint = '/orders';
  static const String profileEndpoint = '/profile';

  // Storage Keys (for future use with SharedPreferences)
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String cartDataKey = 'cart_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
}

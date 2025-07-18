import '../models/user_model.dart';

class UserService {
  // Simulated user data - in real app, this would come from API
  static UserModel? _currentUser;

  // Get current user
  static UserModel? getCurrentUser() {
    return _currentUser;
  }

  // Set current user
  static void setCurrentUser(UserModel user) {
    _currentUser = user;
  }

  // Login user
  static Future<UserModel?> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // Simulate login validation
    if (email == 'user@example.com' && password == 'password') {
      final user = UserModel(
        id: 'user1',
        name: 'Chinmoy',
        email: email,
        phone: '+91 9876543210',
        address: '69b, Jalukbari, Guwahati, Assam',
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastLoginAt: DateTime.now(),
      );

      _currentUser = user;
      return user;
    }

    return null;
  }

  // Register user
  static Future<UserModel?> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String address,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    // Simulate registration
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      address: address,
      isVerified: false,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    return user;
  }

  // Logout user
  static Future<void> logoutUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  // Update user profile
  static Future<UserModel?> updateProfile({
    String? name,
    String? phone,
    String? address,
    String? profileImage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (_currentUser == null) return null;

    final updatedUser = _currentUser!.copyWith(
      name: name,
      phone: phone,
      address: address,
      profileImage: profileImage,
    );

    _currentUser = updatedUser;
    return updatedUser;
  }

  // Change password
  static Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Simulate password change validation
    if (currentPassword == 'password') {
      return true;
    }

    return false;
  }

  // Verify email
  static Future<bool> verifyEmail(String verificationCode) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate email verification
    if (verificationCode == '123456') {
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(isVerified: true);
      }
      return true;
    }

    return false;
  }

  // Send verification code
  static Future<bool> sendVerificationCode(String email) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Simulate sending verification code
    return true;
  }

  // Reset password
  static Future<bool> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 700));

    // Simulate password reset
    return true;
  }

  // Get user statistics
  static Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return {
      'totalOrders': 15,
      'favoriteRestaurants': 8,
      'totalSpent': 2500.0,
      'memberSince': '30 days ago',
      'loyaltyPoints': 150,
    };
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _currentUser != null;
  }

  // Get user initials
  static String getUserInitials() {
    if (_currentUser != null) {
      return _currentUser!.initials;
    }
    return '';
  }

  // Get user display name
  static String getUserDisplayName() {
    if (_currentUser != null) {
      return _currentUser!.name;
    }
    return 'Guest';
  }

  // Get user address
  static String getUserAddress() {
    if (_currentUser != null) {
      return _currentUser!.address;
    }
    return '';
  }

  // Check if user is verified
  static bool isUserVerified() {
    if (_currentUser != null) {
      return _currentUser!.isVerified;
    }
    return false;
  }
}

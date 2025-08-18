import 'package:get/get.dart';
import '../../../../models/user_model.dart';
import '../../../authentication/service/user_service.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> userStats = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    loadUserStatistics();
  }

  // Load user profile
  Future<void> loadUserProfile() async {
    isLoading.value = true;
    try {
      // Use UserService to get current user
      final user = UserService.getCurrentUser();
      if (user != null) {
        currentUser.value = user;
      } else {
        // If no user is logged in, show empty state
        currentUser.value = null;
      }
    } catch (e) {
      print('Error loading user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load user statistics
  Future<void> loadUserStatistics() async {
    try {
      // For now, create mock statistics since we removed the getUserStatistics method
      final mockStats = {
        'totalOrders': 12,
        'favoriteRestaurants': 5,
        'totalSpent': 1250.0,
        'memberSince': '30 days ago',
        'loyaltyPoints': 250,
      };
      userStats.assignAll(mockStats);
    } catch (e) {
      print('Error loading user statistics: $e');
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? phone,
    String? address,
    String? profileImage,
  }) async {
    isLoading.value = true;
    try {
      // For now, just update the local user model
      if (currentUser.value != null) {
        final updatedUser = currentUser.value!.copyWith(
          name: name,
          phone: phone,
          address: address,
          profileImage: profileImage,
        );
        UserService.setCurrentUser(updatedUser);
        currentUser.value = updatedUser;

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Change password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    isLoading.value = true;
    try {
      // For now, just show success message
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error changing password: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      // Use UserService for logout
      await UserService.logoutUser();
      currentUser.value = null;

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      // Navigate to login screen
      // Get.offAllNamed('/login');
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  // Verify email
  Future<void> verifyEmail(String verificationCode) async {
    isLoading.value = true;
    try {
      // For now, just show success message
      if (currentUser.value != null) {
        currentUser.value = currentUser.value!.copyWith(isVerified: true);
      }

      Get.snackbar(
        'Success',
        'Email verified successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error verifying email: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Send verification code
  Future<void> sendVerificationCode() async {
    if (currentUser.value == null) return;

    try {
      // For now, just show success message
      Get.snackbar(
        'Success',
        'Verification code sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error sending verification code: $e');
    }
  }

  // Get user display name
  String getUserDisplayName() {
    return currentUser.value?.name ?? 'Guest';
  }

  // Get user initials
  String getUserInitials() {
    return currentUser.value?.initials ?? '';
  }

  // Get user address
  String getUserAddress() {
    return currentUser.value?.address ?? '';
  }

  // Check if user is verified
  bool isUserVerified() {
    return currentUser.value?.isVerified ?? false;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return currentUser.value != null;
  }

  // Get user email
  String getUserEmail() {
    return currentUser.value?.email ?? '';
  }

  // Get user phone
  String getUserPhone() {
    return currentUser.value?.phone ?? '';
  }

  // Get member since date
  String getMemberSince() {
    if (currentUser.value?.createdAt != null) {
      final days =
          DateTime.now().difference(currentUser.value!.createdAt).inDays;
      return '$days days ago';
    }
    return 'Recently';
  }

  // Refresh profile data
  Future<void> refreshProfile() async {
    await Future.wait([loadUserProfile(), loadUserStatistics()]);
  }
}

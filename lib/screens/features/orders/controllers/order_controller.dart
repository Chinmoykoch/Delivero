import 'package:get/get.dart';
import '../../../../models/order_model.dart';
import '../../../../services/order_service.dart';

class OrderController extends GetxController {
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxList<OrderModel> recentOrders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedStatus = 'All'.obs;
  final RxMap<String, dynamic> statistics = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    loadStatistics();
  }

  // Load all orders
  Future<void> loadOrders() async {
    isLoading.value = true;
    try {
      final userOrders = await OrderService.getUserOrders('user1');
      orders.assignAll(userOrders);

      // Load recent orders
      final recent = await OrderService.getRecentOrders('user1', limit: 5);
      recentOrders.assignAll(recent);
    } catch (e) {
      print('Error loading orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Load order statistics
  Future<void> loadStatistics() async {
    try {
      final stats = await OrderService.getOrderStatistics('user1');
      statistics.assignAll(stats);
    } catch (e) {
      print('Error loading statistics: $e');
    }
  }

  // Get orders by status
  Future<void> getOrdersByStatus(String status) async {
    selectedStatus.value = status;

    if (status == 'All') {
      await loadOrders();
      return;
    }

    try {
      final statusEnum = _getOrderStatusFromString(status);
      final filteredOrders = await OrderService.getOrdersByStatus(
        'user1',
        statusEnum,
      );
      orders.assignAll(filteredOrders);
    } catch (e) {
      print('Error filtering orders: $e');
    }
  }

  // Get order by ID
  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      return await OrderService.getOrderById(orderId);
    } catch (e) {
      print('Error getting order: $e');
      return null;
    }
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    try {
      final success = await OrderService.cancelOrder(orderId);
      if (success) {
        Get.snackbar(
          'Success',
          'Order cancelled successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        await loadOrders(); // Refresh orders
      } else {
        Get.snackbar(
          'Error',
          'Unable to cancel order',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error cancelling order: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Track order
  Future<Map<String, dynamic>?> trackOrder(String orderId) async {
    try {
      return await OrderService.getOrderTracking(orderId);
    } catch (e) {
      print('Error tracking order: $e');
      return null;
    }
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    await Future.wait([loadOrders(), loadStatistics()]);
  }

  // Get order status options
  List<String> getStatusOptions() {
    return [
      'All',
      'Pending',
      'Confirmed',
      'Preparing',
      'Out for Delivery',
      'Delivered',
      'Cancelled',
    ];
  }

  // Get orders count by status
  int getOrdersCountByStatus(String status) {
    if (status == 'All') return orders.length;

    final statusEnum = _getOrderStatusFromString(status);
    return orders.where((order) => order.status == statusEnum).length;
  }

  // Get total spent
  double getTotalSpent() {
    return orders
        .where((order) => order.isDelivered)
        .fold(0.0, (sum, order) => sum + order.finalAmount);
  }

  // Get average order value
  double getAverageOrderValue() {
    final deliveredOrders = orders.where((order) => order.isDelivered).toList();
    if (deliveredOrders.isEmpty) return 0.0;

    final totalSpent = deliveredOrders.fold(
      0.0,
      (sum, order) => sum + order.finalAmount,
    );
    return totalSpent / deliveredOrders.length;
  }

  // Helper method to convert string to OrderStatus enum
  OrderStatus _getOrderStatusFromString(String status) {
    switch (status) {
      case 'Pending':
        return OrderStatus.pending;
      case 'Confirmed':
        return OrderStatus.confirmed;
      case 'Preparing':
        return OrderStatus.preparing;
      case 'Out for Delivery':
        return OrderStatus.outForDelivery;
      case 'Delivered':
        return OrderStatus.delivered;
      case 'Cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  // Check if order can be cancelled
  bool canCancelOrder(OrderModel order) {
    return order.canBeCancelled;
  }

  // Get order status color
  String getOrderStatusColor(OrderModel order) {
    return order.statusColor;
  }

  // Get order status text
  String getOrderStatusText(OrderModel order) {
    return order.statusText;
  }
}

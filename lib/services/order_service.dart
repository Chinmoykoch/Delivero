import '../models/order_model.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';

class OrderService {
  // Simulated orders data - in real app, this would come from API
  static final List<OrderModel> _orders = [
    OrderModel(
      id: '1',
      userId: 'user1',
      items: CartModel(
        items: [],
      ), // This would be populated with actual cart items
      totalAmount: 540.0,
      deliveryFee: 30.0,
      tax: 25.0,
      finalAmount: 595.0,
      status: OrderStatus.delivered,
      deliveryAddress: '69b, Jalukbari, Guwahati, Assam',
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      estimatedDeliveryTime: DateTime.now().subtract(
        const Duration(days: 2, hours: 1),
      ),
      actualDeliveryTime: DateTime.now().subtract(
        const Duration(days: 2, hours: 1),
      ),
      paymentMethod: 'Cash on Delivery',
      isPaid: true,
      trackingNumber: 'TRK123456789',
    ),
    OrderModel(
      id: '2',
      userId: 'user1',
      items: CartModel(items: []),
      totalAmount: 320.0,
      deliveryFee: 30.0,
      tax: 15.0,
      finalAmount: 365.0,
      status: OrderStatus.outForDelivery,
      deliveryAddress: '69b, Jalukbari, Guwahati, Assam',
      orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      estimatedDeliveryTime: DateTime.now().add(const Duration(hours: 1)),
      paymentMethod: 'Online Payment',
      isPaid: true,
      trackingNumber: 'TRK987654321',
    ),
    OrderModel(
      id: '3',
      userId: 'user1',
      items: CartModel(items: []),
      totalAmount: 180.0,
      deliveryFee: 30.0,
      tax: 10.0,
      finalAmount: 220.0,
      status: OrderStatus.preparing,
      deliveryAddress: '69b, Jalukbari, Guwahati, Assam',
      orderDate: DateTime.now().subtract(const Duration(minutes: 30)),
      estimatedDeliveryTime: DateTime.now().add(
        const Duration(hours: 1, minutes: 30),
      ),
      paymentMethod: 'Cash on Delivery',
      isPaid: false,
      trackingNumber: 'TRK456789123',
    ),
  ];

  // Get all orders for a user
  static Future<List<OrderModel>> getUserOrders(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _orders.where((order) => order.userId == userId).toList();
  }

  // Get order by ID
  static Future<OrderModel?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  // Create new order
  static Future<OrderModel> createOrder({
    required String userId,
    required CartModel cart,
    required String deliveryAddress,
    String? specialInstructions,
    String? paymentMethod,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final deliveryFee = 30.0;
    final tax = cart.totalAmount * 0.05; // 5% tax
    final finalAmount = cart.totalAmount + deliveryFee + tax;

    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: cart,
      totalAmount: cart.totalAmount,
      deliveryFee: deliveryFee,
      tax: tax,
      finalAmount: finalAmount,
      status: OrderStatus.pending,
      deliveryAddress: deliveryAddress,
      specialInstructions: specialInstructions,
      orderDate: DateTime.now(),
      estimatedDeliveryTime: DateTime.now().add(const Duration(hours: 1)),
      paymentMethod: paymentMethod ?? 'Cash on Delivery',
      isPaid: paymentMethod == 'Online Payment',
      trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
    );

    _orders.add(newOrder);
    return newOrder;
  }

  // Update order status
  static Future<OrderModel?> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) return null;

    final updatedOrder = _orders[orderIndex].copyWith(status: status);
    _orders[orderIndex] = updatedOrder;

    return updatedOrder;
  }

  // Cancel order
  static Future<bool> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex == -1) return false;

    final order = _orders[orderIndex];
    if (!order.canBeCancelled) return false;

    _orders[orderIndex] = order.copyWith(status: OrderStatus.cancelled);
    return true;
  }

  // Get order tracking info
  static Future<Map<String, dynamic>> getOrderTracking(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final order = _orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => throw Exception('Order not found'),
    );

    return {
      'orderNumber': order.orderNumber,
      'status': order.statusText,
      'statusColor': order.statusColor,
      'trackingNumber': order.trackingNumber,
      'estimatedDelivery': order.estimatedDeliveryTime,
      'actualDelivery': order.actualDeliveryTime,
      'orderDate': order.orderDate,
      'deliveryAddress': order.deliveryAddress,
    };
  }

  // Get recent orders
  static Future<List<OrderModel>> getRecentOrders(
    String userId, {
    int limit = 5,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final userOrders =
        _orders.where((order) => order.userId == userId).toList();
    userOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    return userOrders.take(limit).toList();
  }

  // Get orders by status
  static Future<List<OrderModel>> getOrdersByStatus(
    String userId,
    OrderStatus status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders
        .where((order) => order.userId == userId && order.status == status)
        .toList();
  }

  // Get order statistics
  static Future<Map<String, dynamic>> getOrderStatistics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final userOrders =
        _orders.where((order) => order.userId == userId).toList();

    int totalOrders = userOrders.length;
    int deliveredOrders = userOrders.where((order) => order.isDelivered).length;
    int cancelledOrders = userOrders.where((order) => order.isCancelled).length;
    double totalSpent = userOrders
        .where((order) => order.isDelivered)
        .fold(0.0, (sum, order) => sum + order.finalAmount);

    return {
      'totalOrders': totalOrders,
      'deliveredOrders': deliveredOrders,
      'cancelledOrders': cancelledOrders,
      'totalSpent': totalSpent,
      'averageOrderValue': totalOrders > 0 ? totalSpent / deliveredOrders : 0.0,
    };
  }
}

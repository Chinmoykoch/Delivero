import 'cart_model.dart';
import 'user_model.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

class OrderModel {
  final String id;
  final String userId;
  final CartModel items;
  final double totalAmount;
  final double deliveryFee;
  final double tax;
  final double finalAmount;
  final OrderStatus status;
  final String deliveryAddress;
  final String? specialInstructions;
  final DateTime orderDate;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final String? paymentMethod;
  final bool isPaid;
  final String? trackingNumber;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    this.deliveryFee = 0.0,
    this.tax = 0.0,
    required this.finalAmount,
    this.status = OrderStatus.pending,
    required this.deliveryAddress,
    this.specialInstructions,
    required this.orderDate,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    this.paymentMethod,
    this.isPaid = false,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: CartModel.fromJson(json['items'] ?? {}),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0.0).toDouble(),
      tax: (json['tax'] ?? 0.0).toDouble(),
      finalAmount: (json['finalAmount'] ?? 0.0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.pending,
      ),
      deliveryAddress: json['deliveryAddress'] ?? '',
      specialInstructions: json['specialInstructions'],
      orderDate: DateTime.parse(
        json['orderDate'] ?? DateTime.now().toIso8601String(),
      ),
      estimatedDeliveryTime:
          json['estimatedDeliveryTime'] != null
              ? DateTime.parse(json['estimatedDeliveryTime'])
              : null,
      actualDeliveryTime:
          json['actualDeliveryTime'] != null
              ? DateTime.parse(json['actualDeliveryTime'])
              : null,
      paymentMethod: json['paymentMethod'],
      isPaid: json['isPaid'] ?? false,
      trackingNumber: json['trackingNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.toJson(),
      'totalAmount': totalAmount,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'finalAmount': finalAmount,
      'status': status.toString().split('.').last,
      'deliveryAddress': deliveryAddress,
      'specialInstructions': specialInstructions,
      'orderDate': orderDate.toIso8601String(),
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'actualDeliveryTime': actualDeliveryTime?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'trackingNumber': trackingNumber,
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    CartModel? items,
    double? totalAmount,
    double? deliveryFee,
    double? tax,
    double? finalAmount,
    OrderStatus? status,
    String? deliveryAddress,
    String? specialInstructions,
    DateTime? orderDate,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    String? paymentMethod,
    bool? isPaid,
    String? trackingNumber,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      finalAmount: finalAmount ?? this.finalAmount,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      orderDate: orderDate ?? this.orderDate,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      actualDeliveryTime: actualDeliveryTime ?? this.actualDeliveryTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return '#FFA500'; // Orange
      case OrderStatus.confirmed:
        return '#0000FF'; // Blue
      case OrderStatus.preparing:
        return '#FFD700'; // Gold
      case OrderStatus.outForDelivery:
        return '#FF69B4'; // Pink
      case OrderStatus.delivered:
        return '#32CD32'; // Green
      case OrderStatus.cancelled:
        return '#FF0000'; // Red
    }
  }

  bool get isDelivered => status == OrderStatus.delivered;
  bool get isCancelled => status == OrderStatus.cancelled;
  bool get canBeCancelled =>
      status == OrderStatus.pending || status == OrderStatus.confirmed;

  int get itemCount => items.totalItems;

  String get orderNumber => '#${id.substring(0, 8).toUpperCase()}';

  String get formattedOrderDate {
    return '${orderDate.day}/${orderDate.month}/${orderDate.year}';
  }

  String get formattedOrderTime {
    return '${orderDate.hour.toString().padLeft(2, '0')}:${orderDate.minute.toString().padLeft(2, '0')}';
  }
}

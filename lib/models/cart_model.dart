import 'food_model.dart';

class CartItemModel {
  final FoodModel food;
  final int quantity;

  CartItemModel({required this.food, required this.quantity});

  double get totalPrice {
    // Extract numeric value from price string (e.g., "₹ 240" -> 240)
    final priceString = food.price.replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(priceString) ?? 0.0;
    return price * quantity;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      food: FoodModel.fromJson(json['food'] ?? {}),
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'food': food.toJson(), 'quantity': quantity};
  }
}

class CartModel {
  final List<CartItemModel> items;

  CartModel({this.items = const []});

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get isEmpty => items.isEmpty;

  CartModel addItem(FoodModel food, int quantity) {
    final existingIndex = items.indexWhere((item) => item.food.id == food.id);

    if (existingIndex != -1) {
      // Update existing item quantity
      final updatedItems = List<CartItemModel>.from(items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = CartItemModel(
        food: existingItem.food,
        quantity: existingItem.quantity + quantity,
      );
      return CartModel(items: updatedItems);
    } else {
      // Add new item
      final newItem = CartItemModel(food: food, quantity: quantity);
      return CartModel(items: [...items, newItem]);
    }
  }

  CartModel removeItem(String foodId) {
    return CartModel(
      items: items.where((item) => item.food.id != foodId).toList(),
    );
  }

  CartModel updateQuantity(String foodId, int quantity) {
    if (quantity <= 0) {
      return removeItem(foodId);
    }

    final updatedItems =
        items.map((item) {
          if (item.food.id == foodId) {
            return CartItemModel(food: item.food, quantity: quantity);
          }
          return item;
        }).toList();

    return CartModel(items: updatedItems);
  }

  CartModel clear() {
    return CartModel(items: []);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final items =
        itemsList
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
    return CartModel(items: items);
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((item) => item.toJson()).toList()};
  }
}

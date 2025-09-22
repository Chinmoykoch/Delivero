class FoodModel {
  final String id;
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final String category;
  final double rating;
  final int reviews;
  final String restaurant;
  final String deliveryTime;
  final bool isAvailable;
  
  // API fields
  final String? restaurantId;
  final String? imageUrl;
  final double? apiPrice;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.restaurant,
    required this.deliveryTime,
    this.isAvailable = true,
    // API fields
    this.restaurantId,
    this.imageUrl,
    this.apiPrice,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      imagePath: json['imagePath']?.toString() ?? json['image_url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviews: json['reviews'] ?? 0,
      restaurant: json['restaurant']?.toString() ?? '',
      deliveryTime: json['deliveryTime']?.toString() ?? '',
      isAvailable: json['isAvailable'] ?? true,
      // API fields
      restaurantId: json['restaurant_id']?.toString(),
      imageUrl: json['image_url']?.toString(),
      apiPrice: json['price'] is num ? (json['price'] as num).toDouble() : null,
    );
  }

  // Factory method specifically for API responses
  factory FoodModel.fromApiJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price'] != null ? '₹ ${json['price']}' : '₹ 0',
      imagePath: json['image_url']?.toString() ?? '',
      description: 'Delicious ${json['name']?.toString().toLowerCase() ?? 'food'}',
      category: 'Food',
      rating: 4.0 + (double.tryParse(json['id']?.toString() ?? '0') ?? 0) * 0.1,
      reviews: 20 + ((int.tryParse(json['id']?.toString() ?? '0') ?? 0) * 5),
      restaurant: 'Restaurant',
      deliveryTime: '25-30 mins',
      isAvailable: true,
      // API fields
      restaurantId: json['restaurant_id']?.toString(),
      imageUrl: json['image_url']?.toString(),
      apiPrice: json['price'] is num ? (json['price'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': apiPrice ?? double.tryParse(price.replaceAll('₹', '').trim()),
      'imagePath': imagePath,
      'image_url': imageUrl ?? imagePath,
      'description': description,
      'category': category,
      'rating': rating,
      'reviews': reviews,
      'restaurant': restaurant,
      'restaurant_id': restaurantId,
      'deliveryTime': deliveryTime,
      'isAvailable': isAvailable,
    };
  }

  // Method for API submission
  Map<String, dynamic> toApiJson() {
    return {
      'name': name,
      'restaurant_id': restaurantId,
      'price': apiPrice ?? double.tryParse(price.replaceAll('₹', '').trim()),
      'image_url': imageUrl ?? imagePath,
    };
  }
}

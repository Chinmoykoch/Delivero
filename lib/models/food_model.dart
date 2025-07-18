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
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      imagePath: json['imagePath'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviews: json['reviews'] ?? 0,
      restaurant: json['restaurant'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'description': description,
      'category': category,
      'rating': rating,
      'reviews': reviews,
      'restaurant': restaurant,
      'deliveryTime': deliveryTime,
      'isAvailable': isAvailable,
    };
  }
}

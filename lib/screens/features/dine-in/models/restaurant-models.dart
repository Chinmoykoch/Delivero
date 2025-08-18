class RestaurantModel {
  final String name;
  final String description;
  final double rating;
  final String address;
  final String img_url;
  final String distance;

  RestaurantModel({
    required this.name,
    required this.description,
    required this.rating,
    required this.address,
    required this.img_url,
    required this.distance,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      address: json['address']?.toString() ?? '',
      img_url: json['img_url']?.toString() ?? '',
      distance: json['distance']?.toString() ?? '5kms away', // Default distance
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rating': rating,
      'address': address,
      'img_url': img_url,
      'distance': distance,
    };
  }

  @override
  String toString() {
    return 'RestaurantModel(name: $name, address: $address, img_url: $img_url, rating: $rating)';
  }
}

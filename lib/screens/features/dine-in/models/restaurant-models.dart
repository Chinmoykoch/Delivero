

class RestaurantModel {
  final String id;
  final String name;
  final String? logoUrl;
  final String? bannerUrl;
  final double lat;
  final double lng;
  final DateTime? createdAt;
  final List<dynamic>? foodItems;
  
  // Keep backward compatibility fields for UI
  final String description;
  final double rating;
  final String address;
  final String distance;

  RestaurantModel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.bannerUrl,
    required this.lat,
    required this.lng,
    this.createdAt,
    this.foodItems,
    // Backward compatibility fields with defaults
    this.description = '',
    this.rating = 4.2,
    this.address = '',
    this.distance = '5kms away',
  });

  // Computed property for img_url backward compatibility
  String get img_url => bannerUrl ?? logoUrl ?? '';

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logoUrl: json['logo_url']?.toString(),
      bannerUrl: json['banner_url']?.toString(),
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      foodItems: json['food_items'] as List?,
      // Backward compatibility fields
      description: json['description']?.toString() ?? '',
      rating: json['rating']?.toDouble() ?? 4.2,
      address: json['address']?.toString() ?? '',
      distance: json['distance']?.toString() ?? '5kms away',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'banner_url': bannerUrl,
      'lat': lat,
      'lng': lng,
      'created_at': createdAt?.toIso8601String(),
      'food_items': foodItems,
      // Backward compatibility fields
      'description': description,
      'rating': rating,
      'address': address,
      'distance': distance,
    };
  }

  @override
  String toString() {
    return 'RestaurantModel(id: $id, name: $name, logoUrl: $logoUrl, bannerUrl: $bannerUrl, lat: $lat, lng: $lng)';
  }
}

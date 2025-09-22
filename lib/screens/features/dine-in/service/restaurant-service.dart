import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant-models.dart';

class RestaurantApiService {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  // Get all restaurants with food items
  static Future<List<RestaurantModel>> getAllRestaurants() async {
    try {
      print('Fetching all restaurants from API...');
      final response = await http.get(
        Uri.parse('$baseUrl/orderrestaurant/get'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> restaurantList = data['data'];
          print('Restaurant list length: ${restaurantList.length}');

          final restaurants = restaurantList.map((restaurant) {
            print('Processing restaurant: $restaurant');
            final model = RestaurantModel.fromJson(restaurant);
            print('Created model: ${model.name} - ${model.img_url}');
            return model;
          }).toList();

          print('Processed ${restaurants.length} restaurants');
          return restaurants;
        } else {
          throw Exception('API returned success: false or no data');
        }
      } else {
        print('API returned status code: ${response.statusCode}');
        throw Exception('Failed to load restaurants: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getAllRestaurants: $e');
      // Return fallback data if API fails
      return getFallbackRestaurants();
    }
  }

  // Get single restaurant by ID
  static Future<RestaurantModel?> getRestaurantById(String id) async {
    try {
      print('Fetching restaurant with ID: $id');
      final response = await http.get(
        Uri.parse('$baseUrl/orderrestaurant/get/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) { // API returns 201 for single restaurant
        final data = jsonDecode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          return RestaurantModel.fromJson(data['data']);
        } else {
          throw Exception('API returned success: false or no data');
        }
      } else {
        print('API returned status code: ${response.statusCode}');
        throw Exception('Failed to load restaurant: HTTP ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getRestaurantById: $e');
      return null;
    }
  }

  // Create new restaurant
  static Future<RestaurantModel?> createRestaurant(Map<String, dynamic> restaurantData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orderrestaurant/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(restaurantData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['createRestaurants'] != null) {
          return RestaurantModel.fromJson(data['createRestaurants'][0]);
        }
      }
      return null;
    } catch (e) {
      print('Exception in createRestaurant: $e');
      return null;
    }
  }

  // Fallback data when API is not available
  static List<RestaurantModel> getFallbackRestaurants() {
    return [
      RestaurantModel(
        id: '1',
        name: 'Oh Yeah Chicken',
        logoUrl: 'https://via.placeholder.com/100',
        bannerUrl: 'https://via.placeholder.com/400x200',
        lat: 26.1445,
        lng: 91.7362,
        description: 'Delicious chicken dishes',
        rating: 4.2,
        address: '69c Jalukbari, Guwahati',
        distance: '2kms away',
      ),
      RestaurantModel(
        id: '2',
        name: 'The Royal Paradise',
        logoUrl: 'https://via.placeholder.com/100',
        bannerUrl: 'https://via.placeholder.com/400x200',
        lat: 26.1445,
        lng: 91.7362,
        description: 'Royal dining experience',
        rating: 4.5,
        address: 'Fancy Street, Guwahati',
        distance: '3kms away',
      ),
      RestaurantModel(
        id: '3',
        name: 'Foodie\'s Paradise',
        logoUrl: 'https://via.placeholder.com/100',
        bannerUrl: 'https://via.placeholder.com/400x200',
        lat: 26.1445,
        lng: 91.7362,
        description: 'Paradise for food lovers',
        rating: 4.3,
        address: 'Food Street, Guwahati',
        distance: '1.5kms away',
      ),
    ];
  }
}

// Keep the old function for backward compatibility
Future<List<RestaurantModel>> fetchRestaurants() async {
  return RestaurantApiService.getAllRestaurants();
}


// Future<List<RestaurantModel>> fetchRestaurantsByLocation(
//   String location,
// ) async {
//   final response = await http.get(
//     Uri.parse("http://192.168.1.7:8000/api/v1/restaurants/location/$location"),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final List<dynamic> restaurantList = data['restaurants'];

//     return restaurantList
//         .map((restaurant) => RestaurantModel.fromJson(restaurant))
//         .toList();
//   } else {
//     throw Exception("Failed to load restaurants by location");
//   }
// }

// Future<List<RestaurantModel>> fetchRestaurantsByRating(double minRating) async {
//   final response = await http.get(
//     Uri.parse("http://192.168.1.7:8000/api/v1/restaurants/rating/$minRating"),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final List<dynamic> restaurantList = data['restaurants'];

//     return restaurantList
//         .map((restaurant) => RestaurantModel.fromJson(restaurant))
//         .toList();
//   } else {
//     throw Exception("Failed to load restaurants by rating");
//   }
// }

// Future<RestaurantModel?> fetchRestaurantById(String id) async {
//   final response = await http.get(
//     Uri.parse("http://192.168.1.7:8000/api/v1/restaurants/$id"),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     return RestaurantModel.fromJson(data['restaurant']);
//   } else {
//     throw Exception("Failed to load restaurant details");
//   }
// }


//
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant-models.dart';

Future<List<RestaurantModel>> fetchRestaurants() async {
  try {
    print('Fetching restaurants from API...');
    final response = await http.get(
      Uri.parse("http://192.168.34.229:8000/api/v1/restaurants/allrestaurants"),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Decoded data: $data');

      final List<dynamic> restaurantList = data['data'];
      print('Restaurant list length: ${restaurantList.length}');

      final restaurants =
          restaurantList.map((restaurant) {
            print('Processing restaurant: $restaurant');
            final model = RestaurantModel.fromJson(restaurant);
            print('Created model: ${model.name} - ${model.img_url}');
            return model;
          }).toList();

      print('Processed ${restaurants.length} restaurants');
      for (var restaurant in restaurants) {
        print(
          'Restaurant: ${restaurant.name}, Image URL: "${restaurant.img_url}"',
        );
      }

      return restaurants;
    } else {
      print('API returned status code: ${response.statusCode}');
      throw Exception(
        "Failed to load restaurants: HTTP ${response.statusCode}",
      );
    }
  } catch (e) {
    print('Exception in fetchRestaurants: $e');
    throw Exception("Failed to load restaurants: $e");
  }
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
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'permission_handler.dart';

class LocationServices {
  double? latitude;
  double? longitude;
  String? sublocality;
  String? locality;
  String? administrativeArea;

  static double? lastLatitude;
  static double? lastLongitude;
  static String? _cachedLocationDisplay;

  Future<void> getCurrentLocation(BuildContext context) async {
    // Request permission using the permission handler
    bool hasPermission = await PermissionHandler.requestLocationPermission(
      context,
    );
    if (!hasPermission) {
      throw Exception("Location permission is required.");
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );

    latitude = position.latitude;
    longitude = position.longitude;

    lastLatitude = latitude;
    lastLongitude = longitude;

    print('User Latitude: $latitude');
    print('User Longitude: $longitude');

    // Reverse geocode
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude!,
      longitude!,
    );
    if (placemarks.isNotEmpty) {
      sublocality = placemarks[0].subLocality;
      locality = placemarks[0].locality;
      administrativeArea = placemarks[0].administrativeArea;
    }
  }

  String get locationDisplay {
    List<String> parts = [];
    if (sublocality != null && sublocality!.isNotEmpty) parts.add(sublocality!);
    if (locality != null && locality!.isNotEmpty) parts.add(locality!);
    if (administrativeArea != null && administrativeArea!.isNotEmpty)
      parts.add(administrativeArea!);
    return parts.join(', ');
  }

  static Future<String?> getOrFetchLocationDisplay(BuildContext context) async {
    if (_cachedLocationDisplay != null) {
      return _cachedLocationDisplay;
    }
    final service = LocationServices();
    try {
      await service.getCurrentLocation(context);
      _cachedLocationDisplay = service.locationDisplay;
      return _cachedLocationDisplay;
    } catch (e) {
      return null;
    }
  }

  /// Get current location without requesting permission (for when permission is already granted)
  Future<void> getCurrentLocationSilent() async {
    // Check if service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check permission without requesting
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception("Location permission is required.");
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );

    latitude = position.latitude;
    longitude = position.longitude;

    lastLatitude = latitude;
    lastLongitude = longitude;

    print('User Latitude: $latitude');
    print('User Longitude: $longitude');

    // Reverse geocode
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude!,
      longitude!,
    );
    if (placemarks.isNotEmpty) {
      sublocality = placemarks[0].subLocality;
      locality = placemarks[0].locality;
      administrativeArea = placemarks[0].administrativeArea;
    }
  }
}

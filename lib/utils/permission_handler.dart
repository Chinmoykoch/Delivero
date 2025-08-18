import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class PermissionHandler {
  /// Request location permission and return the result
  static Future<bool> requestLocationPermission(BuildContext context) async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationServiceDialog(context);
        return false;
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          _showPermissionDeniedDialog(context);
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDeniedForeverDialog(context);
        return false;
      }

      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      print('Error requesting location permission: $e');
      // Show a user-friendly error dialog
      _showErrorDialog(
        context,
        'Location services are not available. Please try again later.',
      );
      return false;
    }
  }

  /// Check if location permission is granted
  static Future<bool> hasLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      print('Error checking location permission: $e');
      return false;
    }
  }

  /// Test if geolocator plugin is properly initialized
  static Future<bool> isGeolocatorAvailable() async {
    try {
      // Try to check location service status
      await Geolocator.isLocationServiceEnabled();
      return true;
    } catch (e) {
      print('Geolocator plugin not available: $e');
      return false;
    }
  }

  /// Show dialog when location services are disabled
  static void _showLocationServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
            'Please enable location services in your device settings to use this feature.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Show dialog when permission is denied
  static void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'This app needs location permission to provide you with the best delivery experience.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                requestLocationPermission(context);
              },
              child: const Text('Grant Permission'),
            ),
          ],
        );
      },
    );
  }

  /// Show dialog when permission is denied forever
  static void _showPermissionDeniedForeverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
            'Location permission has been permanently denied. Please enable it in your device settings to use this feature.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Show error dialog for general location errors
  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

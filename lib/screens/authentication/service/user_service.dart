import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/user_model.dart';

class UserService {
  static UserModel? _currentUser;
  static String? _authToken;

  // Base URL for your API
  static const String baseUrl = "http://192.168.34.229:8000/api/v1/users";

  // Get current user
  static UserModel? getCurrentUser() {
    return _currentUser;
  }

  // Get auth token
  static String? getAuthToken() {
    return _authToken;
  }

  // Set current user
  static void setCurrentUser(UserModel user) {
    _currentUser = user;
  }

  // Set auth token
  static void setAuthToken(String token) {
    _authToken = token;
  }

  static Map<String, dynamic> _buildErrorFromResponse(http.Response response) {
    final contentType = response.headers['content-type'] ?? '';
    final bodyPreview =
        response.body.length > 200
            ? response.body.substring(0, 200)
            : response.body;
    final url = response.request?.url.toString() ?? 'unknown';
    if (!contentType.contains('application/json')) {
      return {
        'success': false,
        'message':
            'Server returned non-JSON (status ${response.statusCode}). Verify endpoint: $url. Body preview: ${bodyPreview.replaceAll('\n', ' ')}',
      };
    }
    try {
      final decoded = jsonDecode(response.body);
      return decoded is Map<String, dynamic>
          ? decoded
          : {
            'success': false,
            'message': 'Unexpected response shape from $url',
          };
    } catch (e) {
      return {
        'success': false,
        'message':
            'Failed to parse JSON from $url: $e. Body: ${bodyPreview.replaceAll('\n', ' ')}',
      };
    }
  }

  // Login user
  static Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print(
        'Login request => ${response.request?.method} ${response.request?.url}',
      );
      print(
        'Login status => ${response.statusCode}, content-type: ${response.headers['content-type']}',
      );

      final parsed = _buildErrorFromResponse(response);

      if (response.statusCode == 200 && parsed['success'] == true) {
        _authToken = parsed['token'];
        final userData = parsed['user'];
        final user = UserModel(
          id: userData['id'].toString(),
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phone'] ?? '',
          address: userData['address'] ?? '',
          isVerified: true,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        );
        _currentUser = user;
        return {
          'success': true,
          'message': parsed['message'] ?? 'Login successful',
          'user': user,
          'token': _authToken,
        };
      }

      // Fallback: return parsed error message
      return {
        'success': false,
        'message':
            parsed['message'] ?? 'Login failed (status ${response.statusCode})',
      };
    } catch (error) {
      print('Login error: $error');
      return {'success': false, 'message': 'Network error: $error'};
    }
  }

  // Register user
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/register');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'address': address,
          'role': 'user',
        }),
      );

      print(
        'Register request => ${response.request?.method} ${response.request?.url}',
      );
      print(
        'Register status => ${response.statusCode}, content-type: ${response.headers['content-type']}',
      );

      final parsed = _buildErrorFromResponse(response);

      if (response.statusCode == 201 && parsed['success'] == true) {
        _authToken = parsed['token'];
        final userData = parsed['user'];
        final user = UserModel(
          id: userData['id'].toString(),
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phone'] ?? '',
          address: userData['address'] ?? '',
          isVerified: false,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        );
        _currentUser = user;
        return {
          'success': true,
          'message': parsed['message'] ?? 'Registration successful',
          'user': user,
          'token': _authToken,
        };
      }

      return {
        'success': false,
        'message':
            parsed['message'] ??
            'Registration failed (status ${response.statusCode})',
      };
    } catch (error) {
      print('Register error: $error');
      return {'success': false, 'message': 'Network error: $error'};
    }
  }

  // Logout user
  static Future<void> logoutUser() async {
    _currentUser = null;
    _authToken = null;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _currentUser != null && _authToken != null;
  }

  // Check if user is verified
  static bool isUserVerified() {
    if (_currentUser != null) {
      return _currentUser!.isVerified;
    }
    return false;
  }

  // Get user initials
  static String getUserInitials() {
    if (_currentUser != null) {
      return _currentUser!.initials;
    }
    return '';
  }

  // Get user display name
  static String getUserDisplayName() {
    if (_currentUser != null) {
      return _currentUser!.name;
    }
    return 'Guest';
  }

  // Get user address
  static String getUserAddress() {
    if (_currentUser != null) {
      return _currentUser!.address;
    }
    return '';
  }
}

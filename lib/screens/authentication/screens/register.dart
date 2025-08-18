import 'package:delivero/navigation.dart';
import 'package:delivero/screens/features/checkout/checkout.dart';
import 'package:delivero/screens/authentication/screens/login.dart';
import 'package:delivero/screens/authentication/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Confirm password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Handle registration
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await UserService.registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (result['success']) {
        // Show success message
        Get.snackbar(
          'Success',
          result['message'] ?? 'Registration successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to main app
        Get.offAll(() => Navigation());
      } else {
        // Show error message
        Get.snackbar(
          'Error',
          result['message'] ?? 'Registration failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Network error: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeGreen = const Color(0xFF00936D);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height * 0.85 -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Create Account",
                        style: GoogleFonts.montserrat(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Join Delivero and get your food delivered",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: _validateName,
                        decoration: InputDecoration(
                          hintText: "Enter your full name",
                          hintStyle: GoogleFonts.montserrat(),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: themeGreen,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: themeGreen.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        decoration: InputDecoration(
                          hintText: "Enter your email address",
                          hintStyle: GoogleFonts.montserrat(),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: themeGreen,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: themeGreen.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          hintText: "Create a password",
                          hintStyle: GoogleFonts.montserrat(),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: themeGreen,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeGreen,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: themeGreen.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        validator: _validateConfirmPassword,
                        decoration: InputDecoration(
                          hintText: "Confirm your password",
                          hintStyle: GoogleFonts.montserrat(),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: themeGreen,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: themeGreen,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: themeGreen.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isLoading
                                  ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Text(
                                    'Register',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                _isLoading
                                    ? null
                                    : () {
                                      Get.to(() => LoginScreen());
                                    },
                            child: Text(
                              'Login',
                              style: GoogleFonts.montserrat(
                                color: themeGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

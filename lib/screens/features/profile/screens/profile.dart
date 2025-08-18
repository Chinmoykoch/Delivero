import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Text(
                  "Profile",
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // User Profile Section
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!controller.isLoggedIn()) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Not Logged In',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please login to view your profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar on the left with some margin
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFE5722), Color(0xFFFF8A65)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            controller.getUserInitials().isNotEmpty
                                ? controller.getUserInitials()
                                : 'U',
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Text content with standard spacing and alignment
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.getUserDisplayName(),
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.getUserEmail(),
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            if (controller.getUserPhone().isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                controller.getUserPhone(),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 16),
                Divider(color: Colors.grey[300]),

                // Preference Section
                const SizedBox(height: 8),
                Text(
                  'PREFERENCE',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.black87),
                        title: Text(
                          'Account Settings',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                        ),
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                      ListTile(
                        leading: Icon(Icons.favorite, color: Colors.black87),
                        title: Text(
                          'Favourites',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                        ),
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                    ],
                  ),
                ),

                // Support Section
                const SizedBox(height: 24),
                Text(
                  'SUPPORT & LEGAL',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: Colors.black87,
                        ),
                        title: Text(
                          'Privacy Policy',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                        ),
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                      ListTile(
                        leading: Icon(
                          Icons.description_outlined,
                          color: Colors.black87,
                        ),
                        title: Text(
                          'Terms & Conditions',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                        ),
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey[300]),
                      ListTile(
                        leading: Icon(
                          Icons.help_outline,
                          color: Colors.black87,
                        ),
                        title: Text(
                          'Help & Support',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black38,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // Logout Button
                const SizedBox(height: 24),
                Obx(() {
                  if (!controller.isLoggedIn()) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onTap: () => controller.logout(),
                    ),
                  );
                }),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

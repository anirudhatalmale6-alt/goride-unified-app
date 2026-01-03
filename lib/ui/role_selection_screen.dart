import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goride/services/role_service.dart';
import 'package:goride/themes/app_colors.dart';
import 'package:goride/customer/ui/dashboard_screen.dart' as customer;
import 'package:goride/driver/ui/dashboard_screen.dart' as driver;

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // App Logo
            Center(
              child: Image.asset(
                "assets/app_logo.png",
                width: 150,
              ),
            ),
            const SizedBox(height: 40),
            // Title
            Text(
              'Bem-vindo ao GoRide'.tr,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Como você deseja usar o app?'.tr,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 60),
            // Role Selection Cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Customer Card
                    _buildRoleCard(
                      context,
                      icon: Icons.person,
                      title: 'Passageiro'.tr,
                      description: 'Solicite corridas e viaje com segurança'.tr,
                      onTap: () => _selectRole(UserRole.customer),
                    ),
                    const SizedBox(height: 20),
                    // Driver Card
                    _buildRoleCard(
                      context,
                      icon: Icons.local_taxi,
                      title: 'Motorista'.tr,
                      description: 'Aceite corridas e ganhe dinheiro'.tr,
                      onTap: () => _selectRole(UserRole.driver),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Info
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Você pode trocar entre os modos a qualquer momento'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _selectRole(UserRole role) async {
    final roleService = Get.find<RoleService>();
    await roleService.setRole(role);

    if (role == UserRole.customer) {
      Get.offAll(() => const customer.DashBoardScreen());
    } else {
      Get.offAll(() => const driver.DashBoardScreen());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goride/services/role_service.dart';
import 'package:goride/themes/app_colors.dart';
import 'package:goride/customer/ui/dashboard_screen.dart' as customer;
import 'package:goride/driver/ui/dashboard_screen.dart' as driver;

class RoleSwitcherWidget extends StatelessWidget {
  const RoleSwitcherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<RoleService>(
      builder: (roleService) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRoleButton(
                context,
                title: 'Passageiro'.tr,
                icon: Icons.person,
                isSelected: roleService.isCustomer,
                onTap: () => _switchToCustomer(roleService),
              ),
              _buildRoleButton(
                context,
                title: 'Motorista'.tr,
                icon: Icons.local_taxi,
                isSelected: roleService.isDriver,
                onTap: () => _switchToDriver(roleService),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoleButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.white60,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _switchToCustomer(RoleService roleService) async {
    if (!roleService.isCustomer) {
      await roleService.setRole(UserRole.customer);
      Get.offAll(() => const customer.DashBoardScreen());
    }
  }

  void _switchToDriver(RoleService roleService) async {
    if (!roleService.isDriver) {
      await roleService.setRole(UserRole.driver);
      Get.offAll(() => const driver.DashBoardScreen());
    }
  }
}

// Compact version for AppBar
class RoleSwitcherCompact extends StatelessWidget {
  const RoleSwitcherCompact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<RoleService>(
      builder: (roleService) {
        return Container(
          height: 36,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCompactButton(
                icon: Icons.person,
                isSelected: roleService.isCustomer,
                onTap: () => _switchToCustomer(roleService),
              ),
              _buildCompactButton(
                icon: Icons.local_taxi,
                isSelected: roleService.isDriver,
                onTap: () => _switchToDriver(roleService),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompactButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : Colors.white60,
        ),
      ),
    );
  }

  void _switchToCustomer(RoleService roleService) async {
    if (!roleService.isCustomer) {
      await roleService.setRole(UserRole.customer);
      Get.offAll(() => const customer.DashBoardScreen());
    }
  }

  void _switchToDriver(RoleService roleService) async {
    if (!roleService.isDriver) {
      await roleService.setRole(UserRole.driver);
      Get.offAll(() => const driver.DashBoardScreen());
    }
  }
}

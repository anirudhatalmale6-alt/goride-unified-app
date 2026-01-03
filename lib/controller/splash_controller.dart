import 'dart:async';

import 'package:goride/customer/ui/auth_screen/login_screen.dart' as customer_login;
import 'package:goride/driver/ui/auth_screen/login_screen.dart' as driver_login;
import 'package:goride/customer/ui/dashboard_screen.dart' as customer_dashboard;
import 'package:goride/driver/ui/dashboard_screen.dart' as driver_dashboard;
import 'package:goride/ui/on_boarding_screen.dart';
import 'package:goride/ui/role_selection_screen.dart';
import 'package:goride/services/role_service.dart';
import 'package:goride/utils/Preferences.dart';
import 'package:goride/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => redirectScreen());
    super.onInit();
  }

  redirectScreen() async {
    final roleService = Get.find<RoleService>();

    // Check if onboarding is completed
    if (Preferences.getBoolean(Preferences.isFinishOnBoardingKey) == false) {
      Get.offAll(const OnBoardingScreen());
      return;
    }

    // Check if user has selected a role
    if (!roleService.hasSelectedRole) {
      // Wait a bit for role service to load saved role
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (!roleService.hasSelectedRole) {
      // No role selected, show role selection screen
      Get.offAll(const RoleSelectionScreen());
      return;
    }

    // Check if user is logged in based on role
    bool isLogin = await _checkLogin(roleService.currentRole!);

    if (isLogin) {
      // Navigate to appropriate dashboard
      if (roleService.isCustomer) {
        Get.offAll(const customer_dashboard.DashBoardScreen());
      } else {
        Get.offAll(const driver_dashboard.DashBoardScreen());
      }
    } else {
      // Navigate to appropriate login screen
      if (roleService.isCustomer) {
        Get.offAll(const customer_login.LoginScreen());
      } else {
        Get.offAll(const driver_login.LoginScreen());
      }
    }
  }

  Future<bool> _checkLogin(UserRole role) async {
    if (role == UserRole.customer) {
      return await FireStoreUtils.isLogin();
    } else {
      return await FireStoreUtils.isDriverLogin();
    }
  }
}

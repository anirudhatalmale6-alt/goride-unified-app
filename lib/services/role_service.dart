import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { customer, driver }

class RoleService extends GetxController {
  static RoleService get instance => Get.find<RoleService>();

  static const String _roleKey = 'user_role';

  final Rx<UserRole?> _currentRole = Rx<UserRole?>(null);
  UserRole? get currentRole => _currentRole.value;

  bool get isCustomer => _currentRole.value == UserRole.customer;
  bool get isDriver => _currentRole.value == UserRole.driver;
  bool get hasSelectedRole => _currentRole.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadSavedRole();
  }

  Future<void> _loadSavedRole() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRole = prefs.getString(_roleKey);
    if (savedRole != null) {
      _currentRole.value = savedRole == 'driver' ? UserRole.driver : UserRole.customer;
    }
  }

  Future<void> setRole(UserRole role) async {
    _currentRole.value = role;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role == UserRole.driver ? 'driver' : 'customer');
  }

  Future<void> switchRole() async {
    if (_currentRole.value == UserRole.customer) {
      await setRole(UserRole.driver);
    } else {
      await setRole(UserRole.customer);
    }
  }

  Future<void> clearRole() async {
    _currentRole.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
  }
}

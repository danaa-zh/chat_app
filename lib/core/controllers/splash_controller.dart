import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:chat_app/core/router/app_routes.dart';

class SplashController extends GetxController {
  final AuthController _auth = Get.find<AuthController>();

  @override
  void onReady() {
    super.onReady();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // wait for AuthController to finish initializing
    while (!_auth.isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (_auth.isAuthenticated) {
      Get.offAllNamed(AppRoutes.main);
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
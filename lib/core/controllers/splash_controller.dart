import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/router/app_routes.dart';

class SplashController extends GetxController {
  final AuthController _auth = Get.find<AuthController>();

  @override
  void onReady() {
    super.onReady();
    _checkAuth();
  }

  void _checkAuth() {
    if (_auth.isAuthenticated) {
      Get.offAllNamed(AppRoutes.home);   
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}

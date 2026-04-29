import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class BaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  void setLoading(bool value) => _isLoading.value = value;
  void setError(String message) => _error.value = message;

  void showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color.withValues(alpha: 0.1),
      colorText: color,
      duration: const Duration(seconds: 4),
    );
  }
}

import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/controllers/base_controller.dart';
import 'package:chat_app/core/controllers/change_password_controller.dart';
import 'package:chat_app/core/controllers/forgot_password_controller.dart';
import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/controllers/friends_controller.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/controllers/main_controller.dart';
import 'package:chat_app/core/controllers/notification_controller.dart';
import 'package:chat_app/core/controllers/profile_controller.dart';
import 'package:chat_app/core/controllers/splash_controller.dart';
import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FriendsController>(() => FriendsController());
    Get.lazyPut<UsersListController>(() => UsersListController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<FriendRequestsController>(() => FriendRequestsController());
  }
}
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isInitialized = false.obs;
  final RxBool _isUserNotFound = false.obs; // 👈 added

  // Getters
  User? get user => _user.value;
  UserModel? get userModel => _userModel.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get isAuthenticated => _user.value != null;
  bool get isInitialized => _isInitialized.value;
  bool get isUserNotFound => _isUserNotFound.value; // 👈 added

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
    ever(_user, _handleAuthStateChange);
  }

  void _handleAuthStateChange(User? user) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        if (Get.currentRoute != AppRoutes.login) {
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        if (Get.currentRoute != AppRoutes.main) {
          Get.offAllNamed(AppRoutes.main);
        }
      }
      if (!_isInitialized.value) {
        _isInitialized.value = true;
      }
    });
  }

  void checkInitialAuthState() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user.value = currentUser;
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
    _isInitialized.value = true;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading.value = true;
      _error.value = '';
      _isUserNotFound.value = false; // 👈 reset

      UserModel? userModel = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );

      if (userModel != null) {
        _userModel.value = userModel;
        Get.offAllNamed(AppRoutes.main);
      }
    } on FirebaseAuthException catch (e) {
      // 👈 catch Firebase errors specifically
      if (e.code == 'user-not-found') {
        _isUserNotFound.value = true;
      }
      _error.value = e.code;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  // 👇 added
  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      _error.value = '';
      _isUserNotFound.value = false;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // user cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        Get.offAllNamed(AppRoutes.main);
      }
    } on FirebaseAuthException catch (e) {
      _error.value = e.message ?? 'Google sign in failed';
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      UserModel? userModel = await _authService.registerWithEmailAndPassword(
        email,
        password,
        displayName,
      );

      if (userModel != null) {
        _userModel.value = userModel;
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', 'Failed To Register');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _authService.signOut();
      await GoogleSignIn().signOut(); // 👈 also sign out from Google
      _userModel.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', 'Failed To Sign Out');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteAccount() async {
    try {
      _isLoading.value = true;
      await _authService.deleteAccount();
      _userModel.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', 'Failed To Delete Account');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      _isLoading.value = true;
      _error.value = '';
      await _authService.sendPasswordResetEmail(email);
      Get.snackbar('Success', 'Password reset email sent');
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', 'Failed To Send Reset Email');
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _error.value = '';
    _isUserNotFound.value = false; // 👈 also clear this
  }
}

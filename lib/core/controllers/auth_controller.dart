import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/core/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<User?> _user = Rx<User?>(null);
  Rx<User?> get userStream => _user;
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isInitialized = false.obs;

  User? get user => _user.value;
  UserModel? get userModel => _userModel.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get isAuthenticated => _user.value != null && _userModel.value != null;
  bool get isInitialized => _isInitialized.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
    ever(_user, _handleAuthStateChange); 
    _initAuth();
  }

  Future<void> _initAuth() async {
    final user = await _authService.authStateChanges.first;

    _isInitialized.value = true;

    if (user == null) {
      _user.value = null;
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    _user.value = user;
    await _loadUserModel(user.uid);
    Get.offAllNamed(AppRoutes.main);
  }

  void _handleAuthStateChange(User? user) {
    if (!_isInitialized.value) return;
    if (user == null && _userModel.value != null) {
      _userModel.value = null;
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> _loadUserModel(String uid) async {
    try {
      final userModel = await _authService.getUser(uid);
      if (userModel != null) {
        _userModel.value = userModel;
      }
    } catch (e) {
      Get.log('Failed to load user model: $e');
    }
  }

  String _getUserFriendlyErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-not-found':
        return 'No account found with this email. Please register first.';
      case 'email-already-in-use':
        return 'This email is already registered. Please sign in.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'Invalid email address. Please check and try again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  Future<void> _runAuthAction<T>(
    Future<T> Function() action,
    String successMessage,
  ) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final result = await action();

      if (result != null && result is UserModel) {
        _userModel.value = result;
        Get.offAllNamed(AppRoutes.main); 
      }

      if (successMessage.isNotEmpty) {
        Get.snackbar(
          'Success',
          successMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      _error.value = _getUserFriendlyErrorMessage(e);
      Get.snackbar('Error', _error.value, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', _error.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _runAuthAction<UserModel?>(
      () => _authService.signInWithEmailAndPassword(email, password),
      '',
    );
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    await _runAuthAction<UserModel>(
      () => _authService.registerWithEmailAndPassword(
        email,
        password,
        displayName,
      ),
      '',
    );
  }

  Future<void> signInWithGoogle() async {
    await _runAuthAction<UserModel>(() => _authService.signInWithGoogle(), '');
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      _error.value = '';
      await _authService.signOut();
      _userModel.value = null;
      _user.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', 'Failed To Sign Out');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteAccount() async {
    await _runAuthAction(() async {
      await _authService.deleteAccount();
      _userModel.value = null;
    }, '');
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _runAuthAction(
      () => _authService.sendPasswordResetEmail(email),
      'Password reset email sent. Check your inbox.',
    );
  }

  void clearError() {
    _error.value = '';
  }
}

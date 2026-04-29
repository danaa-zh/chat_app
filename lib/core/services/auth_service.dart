import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> getUser(String uid) async {
    try {
      return await _firestoreService.getUser(uid);
    } catch (e) {
      throw Exception('Failed To Get User: ${e.toString()}');
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {
        await _firestoreService.updateUserOnlineStatus(user.uid, true);
      }
      return await _firestoreService.getUser(user!.uid);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed To Sign In: ${e.toString()}');
    }
  }

  Future<UserModel> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {
        await user.updateDisplayName(displayName);
        final userModel = UserModel(
          id: user.uid,
          email: email,
          displayName: displayName,
          photoURL: '',
          isOnline: true,
          lastSeen: DateTime.now(),
          createdAt: DateTime.now(),
        );
        await _firestoreService.createUser(userModel);
        return userModel;
      }
      throw Exception('User creation failed');
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed To Register: ${e.toString()}');
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign in cancelled');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) throw Exception('Google sign in failed');

      final existingUser = await _firestoreService.getUser(user.uid);
      if (existingUser != null) {
        await _firestoreService.updateUserOnlineStatus(user.uid, true);
        return existingUser;
      }

      final newUser = UserModel(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? 'User',
        photoURL: user.photoURL ?? '',
        isOnline: true,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      await _firestoreService.createUser(newUser);
      return newUser;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed To Sign In With Google: ${e.toString()}');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed To Send Password Reset Email: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      if (currentUser != null) {
        await _firestoreService.updateUserOnlineStatus(currentUserId!, false);
      }
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed To Sign Out: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestoreService.deleteUser(user.uid);
        await user.delete();
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed To Delete Account: ${e.toString()}');
    }
  }
}
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../utils/logger.dart';

// /// Обёртка над [FirebaseAuth] и [GoogleSignIn].
// ///
// /// Зачем нужна обёртка, а не прямые вызовы?
// /// 1. Если Firebase заменится другим сервисом — меняем только этот файл.
// /// 2. Логирование и обработка ошибок в одном месте.
// /// 3. Тестирование — проще подменить один сервис, чем весь Firebase.


// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   User? get currentUser => _auth.currentUser;

//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   /// Запускает флоу входа через Google.
//   Future<UserCredential?> signInWithGoogle() async {
//     final serverClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];
//     if (serverClientId == null) {
//       throw Exception('GOOGLE_WEB_CLIENT_ID is missing in .env');
//     }

//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final userCredential = await _auth.signInWithCredential(credential);

//       AppLogger.info(
//         'Google Sign-In: успешный вход — ${userCredential.user?.email}',
//       );
//       return userCredential;
//     } catch (error, stackTrace) {
//       AppLogger.error(
//         'Google Sign-In: ошибка',
//         error: error,
//         stackTrace: stackTrace,
//       );
//       rethrow;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await Future.wait([
//         _auth.signOut(),
//         _googleSignIn.signOut(),
//       ]);
//       AppLogger.info('FirebaseAuthService: пользователь вышел');
//     } catch (error, stackTrace) {
//       AppLogger.error(
//         'FirebaseAuthService: ошибка выхода',
//         error: error,
//         stackTrace: stackTrace,
//       );
//       rethrow;
//     }
//   }
// }

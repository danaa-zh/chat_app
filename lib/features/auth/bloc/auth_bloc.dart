// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// enum AuthFieldError {
//   none,
//   invalidEmail,
//   requiredPassword,
//   shortPassword,
//   requiredDisplayName,
//   passwordMismatch,
// }

// enum AuthFailure {
//   none,
//   invalidCredentials,
//   userNotFound,
//   wrongPassword,
//   emailAlreadyInUse,
//   weakPassword,
//   network,
//   unknown,
// }

// class AuthState extends Equatable {
//   final String displayName;
//   final String email;
//   final String password;
//   final String confirmPassword;
//   final bool isPasswordObscured;
//   final bool isConfirmPasswordObscured;
//   final bool isLoading;
//   final bool isSuccess;
//   final bool isResetLinkSent;
//   final AuthFieldError displayNameError;
//   final AuthFieldError emailError;
//   final AuthFieldError passwordError;
//   final AuthFieldError confirmPasswordError;
//   final AuthFailure failure;

//   const AuthState({
//     this.displayName = '',
//     this.email = '',
//     this.password = '',
//     this.confirmPassword = '',
//     this.isPasswordObscured = true,
//     this.isConfirmPasswordObscured = true,
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.isResetLinkSent = false,
//     this.displayNameError = AuthFieldError.none,
//     this.emailError = AuthFieldError.none,
//     this.passwordError = AuthFieldError.none,
//     this.confirmPasswordError = AuthFieldError.none,
//     this.failure = AuthFailure.none,
//   });

//   AuthState copyWith({
//     String? displayName,
//     String? email,
//     String? password,
//     String? confirmPassword,
//     bool? isPasswordObscured,
//     bool? isConfirmPasswordObscured,
//     bool? isLoading,
//     bool? isSuccess,
//     bool? isResetLinkSent,
//     AuthFieldError? displayNameError,
//     AuthFieldError? emailError,
//     AuthFieldError? passwordError,
//     AuthFieldError? confirmPasswordError,
//     AuthFailure? failure,
//   }) {
//     return AuthState(
//       displayName: displayName ?? this.displayName,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       confirmPassword: confirmPassword ?? this.confirmPassword,
//       isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
//       isConfirmPasswordObscured:
//           isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       isResetLinkSent: isResetLinkSent ?? this.isResetLinkSent,
//       displayNameError: displayNameError ?? this.displayNameError,
//       emailError: emailError ?? this.emailError,
//       passwordError: passwordError ?? this.passwordError,
//       confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
//       failure: failure ?? this.failure,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         displayName,
//         email,
//         password,
//         confirmPassword,
//         isPasswordObscured,
//         isConfirmPasswordObscured,
//         isLoading,
//         isSuccess,
//         isResetLinkSent,
//         displayNameError,
//         emailError,
//         passwordError,
//         confirmPasswordError,
//         failure,
//       ];
// }

// class AuthBloc extends Cubit<AuthState> {
//   AuthBloc() : super(const AuthState());

//   void onDisplayNameChanged(String value) {
//     emit(
//       state.copyWith(
//         displayName: value.trim(),
//         displayNameError: AuthFieldError.none,
//         failure: AuthFailure.none,
//       ),
//     );
//   }

//   void onEmailChanged(String value) {
//     emit(
//       state.copyWith(
//         email: value.trim(),
//         emailError: AuthFieldError.none,
//         failure: AuthFailure.none,
//       ),
//     );
//   }

//   void onPasswordChanged(String value) {
//     emit(
//       state.copyWith(
//         password: value,
//         passwordError: AuthFieldError.none,
//         failure: AuthFailure.none,
//       ),
//     );
//   }

//   void onConfirmPasswordChanged(String value) {
//     emit(
//       state.copyWith(
//         confirmPassword: value,
//         confirmPasswordError: AuthFieldError.none,
//         failure: AuthFailure.none,
//       ),
//     );
//   }

//   void onTogglePasswordVisibility() {
//     emit(
//       state.copyWith(
//         isPasswordObscured: !state.isPasswordObscured,
//       ),
//     );
//   }

//   void onToggleConfirmPasswordVisibility() {
//     emit(
//       state.copyWith(
//         isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
//       ),
//     );
//   }

//   Future<void> onLoginSubmit() async {
//     final email = state.email.trim();
//     final password = state.password;

//     final emailError = _validateEmail(email);
//     final passwordError = _validatePassword(password);

//     if (emailError != AuthFieldError.none ||
//         passwordError != AuthFieldError.none) {
//       emit(
//         state.copyWith(
//           emailError: emailError,
//           passwordError: passwordError,
//           failure: AuthFailure.none,
//           isSuccess: false,
//         ),
//       );
//       return;
//     }

//     emit(
//       state.copyWith(
//         isLoading: true,
//         failure: AuthFailure.none,
//         isSuccess: false,
//       ),
//     );

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           failure: AuthFailure.none,
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           failure: _mapFailure(e.code),
//         ),
//       );
//     } catch (_) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           failure: AuthFailure.unknown,
//         ),
//       );
//     }
//   }

//   Future<void> onRegisterSubmit() async {
//     final displayName = state.displayName.trim();
//     final email = state.email.trim();
//     final password = state.password;
//     final confirmPassword = state.confirmPassword;

//     final displayNameError = _validateDisplayName(displayName);
//     final emailError = _validateEmail(email);
//     final passwordError = _validatePassword(password);
//     final confirmPasswordError = _validateConfirmPassword(password, confirmPassword);

//     if (displayNameError != AuthFieldError.none ||
//         emailError != AuthFieldError.none ||
//         passwordError != AuthFieldError.none ||
//         confirmPasswordError != AuthFieldError.none) {
//       emit(
//         state.copyWith(
//           displayNameError: displayNameError,
//           emailError: emailError,
//           passwordError: passwordError,
//           confirmPasswordError: confirmPasswordError,
//           failure: AuthFailure.none,
//           isSuccess: false,
//         ),
//       );
//       return;
//     }

//     emit(
//       state.copyWith(
//         isLoading: true,
//         failure: AuthFailure.none,
//         isSuccess: false,
//       ),
//     );

//     try {
//       final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
      
//       await userCredential.user?.updateDisplayName(displayName);
      
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           failure: AuthFailure.none,
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           failure: _mapFailure(e.code),
//         ),
//       );
//     } catch (_) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           failure: AuthFailure.unknown,
//         ),
//       );
//     }
//   }

//   Future<void> onForgotPasswordSubmit() async {
//     final email = state.email.trim();
//     final emailError = _validateEmail(email);

//     if (emailError != AuthFieldError.none) {
//       emit(
//         state.copyWith(
//           emailError: emailError,
//           failure: AuthFailure.none,
//           isResetLinkSent: false,
//         ),
//       );
//       return;
//     }

//     emit(
//       state.copyWith(
//         isLoading: true,
//         failure: AuthFailure.none,
//         isResetLinkSent: false,
//       ),
//     );

//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isResetLinkSent: true,
//           failure: AuthFailure.none,
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isResetLinkSent: false,
//           failure: _mapFailure(e.code),
//         ),
//       );
//     } catch (_) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isResetLinkSent: false,
//           failure: AuthFailure.unknown,
//         ),
//       );
//     }
//   }

//   AuthFieldError _validateDisplayName(String value) {
//     if (value.isEmpty) {
//       return AuthFieldError.requiredDisplayName;
//     }
//     return AuthFieldError.none;
//   }

//   AuthFieldError _validateEmail(String email) {
//     if (email.isEmpty || !email.contains('@')) {
//       return AuthFieldError.invalidEmail;
//     }
//     return AuthFieldError.none;
//   }

//   AuthFieldError _validatePassword(String password) {
//     if (password.isEmpty) {
//       return AuthFieldError.requiredPassword;
//     }
//     if (password.length < 6) {
//       return AuthFieldError.shortPassword;
//     }
//     return AuthFieldError.none;
//   }

//   AuthFieldError _validateConfirmPassword(String password, String confirmPassword) {
//     if (confirmPassword.isEmpty) {
//       return AuthFieldError.requiredPassword;
//     }
//     if (password != confirmPassword) {
//       return AuthFieldError.passwordMismatch;
//     }
//     return AuthFieldError.none;
//   }

//   AuthFailure _mapFailure(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return AuthFailure.userNotFound;
//       case 'wrong-password':
//         return AuthFailure.wrongPassword;
//       case 'invalid-credential':
//         return AuthFailure.invalidCredentials;
//       case 'email-already-in-use':
//         return AuthFailure.emailAlreadyInUse;
//       case 'weak-password':
//         return AuthFailure.weakPassword;
//       case 'network-request-failed':
//         return AuthFailure.network;
//       default:
//         return AuthFailure.unknown;
//     }
//   }
// }

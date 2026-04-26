// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// enum RegisterFieldError {
//   none,
//   requiredField,
//   invalidEmail,
//   shortPassword,
//   passwordMismatch,
// }

// enum RegisterFailure {
//   none,
//   emailAlreadyInUse,
//   weakPassword,
//   network,
//   unknown,
// }

// class RegisterState extends Equatable {
//   final String displayName;
//   final String email;
//   final String password;
//   final String confirmPassword;
//   final bool isPasswordObscured;
//   final bool isConfirmPasswordObscured;
//   final bool isLoading;
//   final bool isSuccess;
//   final RegisterFieldError displayNameError;
//   final RegisterFieldError emailError;
//   final RegisterFieldError passwordError;
//   final RegisterFieldError confirmPasswordError;
//   final RegisterFailure failure;

//   const RegisterState({
//     this.displayName = '',
//     this.email = '',
//     this.password = '',
//     this.confirmPassword = '',
//     this.isPasswordObscured = true,
//     this.isConfirmPasswordObscured = true,
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.displayNameError = RegisterFieldError.none,
//     this.emailError = RegisterFieldError.none,
//     this.passwordError = RegisterFieldError.none,
//     this.confirmPasswordError = RegisterFieldError.none,
//     this.failure = RegisterFailure.none,
//   });

//   RegisterState copyWith({
//     String? displayName,
//     String? email,
//     String? password,
//     String? confirmPassword,
//     bool? isPasswordObscured,
//     bool? isConfirmPasswordObscured,
//     bool? isLoading,
//     bool? isSuccess,
//     RegisterFieldError? displayNameError,
//     RegisterFieldError? emailError,
//     RegisterFieldError? passwordError,
//     RegisterFieldError? confirmPasswordError,
//     RegisterFailure? failure,
//   }) {
//     return RegisterState(
//       displayName: displayName ?? this.displayName,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       confirmPassword: confirmPassword ?? this.confirmPassword,
//       isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
//       isConfirmPasswordObscured:
//           isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
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
//         displayNameError,
//         emailError,
//         passwordError,
//         confirmPasswordError,
//         failure,
//       ];
// }

// class RegisterBloc extends Cubit<RegisterState> {
//   RegisterBloc() : super(const RegisterState());

//   void onDisplayNameChanged(String value) {
//     emit(
//       state.copyWith(
//         displayName: value.trim(),
//         displayNameError: RegisterFieldError.none,
//         failure: RegisterFailure.none,
//       ),
//     );
//   }

//   void onEmailChanged(String value) {
//     emit(
//       state.copyWith(
//         email: value.trim(),
//         emailError: RegisterFieldError.none,
//         failure: RegisterFailure.none,
//       ),
//     );
//   }

//   void onPasswordChanged(String value) {
//     emit(
//       state.copyWith(
//         password: value,
//         passwordError: RegisterFieldError.none,
//         failure: RegisterFailure.none,
//       ),
//     );
//   }

//   void onConfirmPasswordChanged(String value) {
//     emit(
//       state.copyWith(
//         confirmPassword: value,
//         confirmPasswordError: RegisterFieldError.none,
//         failure: RegisterFailure.none,
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

//   Future<void> onSubmit() async {
//     final displayName = state.displayName.trim();
//     final email = state.email.trim();
//     final password = state.password;
//     final confirmPassword = state.confirmPassword;

//     final displayNameError = _validateDisplayName(displayName);
//     final emailError = _validateEmail(email);
//     final passwordError = _validatePassword(password);
//     final confirmPasswordError =
//         _validateConfirmPassword(password, confirmPassword);

//     if (displayNameError != RegisterFieldError.none ||
//         emailError != RegisterFieldError.none ||
//         passwordError != RegisterFieldError.none ||
//         confirmPasswordError != RegisterFieldError.none) {
//       emit(
//         state.copyWith(
//           displayNameError: displayNameError,
//           emailError: emailError,
//           passwordError: passwordError,
//           confirmPasswordError: confirmPasswordError,
//           failure: RegisterFailure.none,
//           isSuccess: false,
//         ),
//       );
//       return;
//     }

//     emit(
//       state.copyWith(
//         isLoading: true,
//         failure: RegisterFailure.none,
//         isSuccess: false,
//       ),
//     );

//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await credential.user?.updateDisplayName(displayName);
//       emit(
//         state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           failure: RegisterFailure.none,
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
//           failure: RegisterFailure.unknown,
//         ),
//       );
//     }
//   }

//   RegisterFieldError _validateDisplayName(String name) {
//     if (name.isEmpty) {
//       return RegisterFieldError.requiredField;
//     }
//     return RegisterFieldError.none;
//   }

//   RegisterFieldError _validateEmail(String email) {
//     if (email.isEmpty || !email.contains('@')) {
//       return RegisterFieldError.invalidEmail;
//     }
//     return RegisterFieldError.none;
//   }

//   RegisterFieldError _validatePassword(String password) {
//     if (password.isEmpty) {
//       return RegisterFieldError.requiredField;
//     }
//     if (password.length < 6) {
//       return RegisterFieldError.shortPassword;
//     }
//     return RegisterFieldError.none;
//   }

//   RegisterFieldError _validateConfirmPassword(
//     String password,
//     String confirmPassword,
//   ) {
//     if (confirmPassword.isEmpty) {
//       return RegisterFieldError.requiredField;
//     }
//     if (confirmPassword != password) {
//       return RegisterFieldError.passwordMismatch;
//     }
//     return RegisterFieldError.none;
//   }

//   RegisterFailure _mapFailure(String code) {
//     switch (code) {
//       case 'email-already-in-use':
//         return RegisterFailure.emailAlreadyInUse;
//       case 'weak-password':
//         return RegisterFailure.weakPassword;
//       case 'network-request-failed':
//         return RegisterFailure.network;
//       default:
//         return RegisterFailure.unknown;
//     }
//   }
// }

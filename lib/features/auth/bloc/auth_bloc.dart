import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthFieldError {
  none,
  invalidEmail,
  requiredPassword,
  shortPassword,
}

enum AuthFailure {
  none,
  invalidCredentials,
  userNotFound,
  wrongPassword,
  network,
  unknown,
}

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordObscured;
  final bool isLoading;
  final bool isSuccess;
  final AuthFieldError emailError;
  final AuthFieldError passwordError;
  final AuthFailure failure;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isPasswordObscured = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.emailError = AuthFieldError.none,
    this.passwordError = AuthFieldError.none,
    this.failure = AuthFailure.none,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isPasswordObscured,
    bool? isLoading,
    bool? isSuccess,
    AuthFieldError? emailError,
    AuthFieldError? passwordError,
    AuthFailure? failure,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isPasswordObscured,
        isLoading,
        isSuccess,
        emailError,
        passwordError,
        failure,
      ];
}

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(const AuthState());

  void onEmailChanged(String value) {
    emit(
      state.copyWith(
        email: value.trim(),
        emailError: AuthFieldError.none,
        failure: AuthFailure.none,
      ),
    );
  }

  void onPasswordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        passwordError: AuthFieldError.none,
        failure: AuthFailure.none,
      ),
    );
  }

  void onTogglePasswordVisibility() {
    emit(
      state.copyWith(
        isPasswordObscured: !state.isPasswordObscured,
      ),
    );
  }

  Future<void> onSubmit() async {
    final email = state.email.trim();
    final password = state.password;

    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

    if (emailError != AuthFieldError.none ||
        passwordError != AuthFieldError.none) {
      emit(
        state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          failure: AuthFailure.none,
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        failure: AuthFailure.none,
        isSuccess: false,
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          failure: AuthFailure.none,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          failure: _mapFailure(e.code),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          failure: AuthFailure.unknown,
        ),
      );
    }
  }

  AuthFieldError _validateEmail(String email) {
    if (email.isEmpty || !email.contains('@')) {
      return AuthFieldError.invalidEmail;
    }
    return AuthFieldError.none;
  }

  AuthFieldError _validatePassword(String password) {
    if (password.isEmpty) {
      return AuthFieldError.requiredPassword;
    }
    if (password.length < 6) {
      return AuthFieldError.shortPassword;
    }
    return AuthFieldError.none;
  }

  AuthFailure _mapFailure(String code) {
    switch (code) {
      case 'user-not-found':
        return AuthFailure.userNotFound;
      case 'wrong-password':
        return AuthFailure.wrongPassword;
      case 'invalid-credential':
        return AuthFailure.invalidCredentials;
      case 'network-request-failed':
        return AuthFailure.network;
      default:
        return AuthFailure.unknown;
    }
  }
}

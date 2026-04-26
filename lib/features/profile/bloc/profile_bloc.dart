// import 'package:flutter_bloc/flutter_bloc.dart';

// // Events
// abstract class ProfileEvent {}

// class LoadProfile extends ProfileEvent {}

// class SignOutPressed extends ProfileEvent {}

// class UpdatePasswordPressed extends ProfileEvent {
//   final String currentPassword;
//   final String newPassword;
//   final String confirmPassword;

//   UpdatePasswordPressed({
//     required this.currentPassword,
//     required this.newPassword,
//     required this.confirmPassword,
//   });
// }

// // States
// abstract class ProfileState {}

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileLoaded extends ProfileState {
//   final String displayName;
//   final String email;
//   final String? username;
//   final String? avatarUrl;
//   final String accountType;
//   final bool isOnline;
//   final bool isPasswordObscured;
//   final bool isNewPasswordObscured;
//   final bool isConfirmPasswordObscured;

//   ProfileLoaded({
//     required this.displayName,
//     required this.email,
//     this.username,
//     this.avatarUrl,
//     required this.accountType,
//     this.isOnline = false,
//     this.isPasswordObscured = true,
//     this.isNewPasswordObscured = true,
//     this.isConfirmPasswordObscured = true,
//   });

//   ProfileLoaded copyWith({
//     String? displayName,
//     String? email,
//     String? username,
//     String? avatarUrl,
//     String? accountType,
//     bool? isOnline,
//     bool? isPasswordObscured,
//     bool? isNewPasswordObscured,
//     bool? isConfirmPasswordObscured,
//   }) {
//     return ProfileLoaded(
//       displayName: displayName ?? this.displayName,
//       email: email ?? this.email,
//       username: username ?? this.username,
//       avatarUrl: avatarUrl ?? this.avatarUrl,
//       accountType: accountType ?? this.accountType,
//       isOnline: isOnline ?? this.isOnline,
//       isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
//       isNewPasswordObscured: isNewPasswordObscured ?? this.isNewPasswordObscured,
//       isConfirmPasswordObscured: isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
//     );
//   }
// }

// class ProfileUpdateSuccess extends ProfileState {}

// class ProfileError extends ProfileState {
//   final String message;
//   ProfileError(this.message);
// }

// // Events
// class TogglePasswordVisibility extends ProfileEvent {
//   final int fieldIndex; // 0: current, 1: new, 2: confirm
//   TogglePasswordVisibility(this.fieldIndex);
// }

// // Bloc
// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(ProfileInitial()) {
//     on<LoadProfile>(_onLoadProfile);
//     on<SignOutPressed>(_onSignOut);
//     on<UpdatePasswordPressed>(_onUpdatePassword);
//     on<TogglePasswordVisibility>(_onToggleVisibility);
    
//     add(LoadProfile());
//   }

//   void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
//     emit(ProfileLoading());
//     await Future.delayed(const Duration(milliseconds: 500));
    
//     emit(ProfileLoaded(
//       displayName: 'Alice Freeman',
//       email: 'alice.freeman@example.com',
//       username: '@alice_f',
//       accountType: 'Premium',
//       isOnline: true,
//     ));
//   }

//   void _onToggleVisibility(TogglePasswordVisibility event, Emitter<ProfileState> emit) {
//     if (state is ProfileLoaded) {
//       final s = state as ProfileLoaded;
//       if (event.fieldIndex == 0) {
//         emit(s.copyWith(isPasswordObscured: !s.isPasswordObscured));
//       } else if (event.fieldIndex == 1) {
//         emit(s.copyWith(isNewPasswordObscured: !s.isNewPasswordObscured));
//       } else {
//         emit(s.copyWith(isConfirmPasswordObscured: !s.isConfirmPasswordObscured));
//       }
//     }
//   }

//   void _onSignOut(SignOutPressed event, Emitter<ProfileState> emit) {
//     // Logic for signing out
//   }

//   void _onUpdatePassword(UpdatePasswordPressed event, Emitter<ProfileState> emit) async {
//     // Basic validation
//     if (event.newPassword != event.confirmPassword) {
//       emit(ProfileError('passwordMismatchError'));
//       return;
//     }

//     emit(ProfileLoading());
//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 1));
    
//     emit(ProfileUpdateSuccess());
    
//     // Reload profile after success
//     add(LoadProfile());
//   }
// }

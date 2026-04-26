// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/router/route_names.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/auth_bloc.dart';
// import 'widgets/app_text_field.dart';
// import 'widgets/auth_footer_link.dart';
// import 'widgets/auth_header.dart';
// import 'widgets/password_text_field.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;

//     return BlocProvider(
//       create: (_) => AuthBloc(),
//       child: BlocConsumer<AuthBloc, AuthState>(
//         listenWhen: (previous, current) =>
//             previous.isSuccess != current.isSuccess ||
//             previous.failure != current.failure,
//         listener: (context, state) {
//           if (state.isSuccess) {
//             context.go(RouteNames.chats);
//             return;
//           }
//           if (state.failure != AuthFailure.none) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(_failureText(loc, state.failure))),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                   AppPaddings.screenHorizontal,
//                   AppSpacings.hero,
//                   AppPaddings.screenHorizontal,
//                   AppSpacings.section,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     AuthHeader(
//                       title: loc.signUp,
//                       subtitle: loc.createAccount,
//                     ),
//                     const SizedBox(height: AppSpacings.screen),
                    
//                     // Display Name
//                     AppTextField(
//                       hintText: loc.displayNameHint,
//                       iconPath: AssetPaths.profileIcon,
//                       hasError: state.displayNameError != AuthFieldError.none,
//                       onChanged: context.read<AuthBloc>().onDisplayNameChanged,
//                     ),
//                     if (state.displayNameError != AuthFieldError.none)
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppSpacings.xs),
//                         child: Text(
//                           _errorText(loc, state.displayNameError),
//                           style: AppTextStyles.timestamp,
//                         ),
//                       ),
//                     const SizedBox(height: AppSpacings.lg),

//                     // Email
//                     AppTextField(
//                       hintText: loc.emailAddressHint,
//                       iconPath: AssetPaths.emailIcon,
//                       keyboardType: TextInputType.emailAddress,
//                       hasError: state.emailError != AuthFieldError.none,
//                       onChanged: context.read<AuthBloc>().onEmailChanged,
//                     ),
//                     if (state.emailError != AuthFieldError.none)
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppSpacings.xs),
//                         child: Text(
//                           _errorText(loc, state.emailError),
//                           style: AppTextStyles.timestamp,
//                         ),
//                       ),
//                     const SizedBox(height: AppSpacings.lg),

//                     // Password
//                     PasswordTextField(
//                       hintText: loc.passwordHint,
//                       isObscured: state.isPasswordObscured,
//                       hasError: state.passwordError != AuthFieldError.none,
//                       onChanged: context.read<AuthBloc>().onPasswordChanged,
//                       onToggleVisibility:
//                           context.read<AuthBloc>().onTogglePasswordVisibility,
//                     ),
//                     if (state.passwordError != AuthFieldError.none)
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppSpacings.xs),
//                         child: Text(
//                           _errorText(loc, state.passwordError),
//                           style: AppTextStyles.timestamp,
//                         ),
//                       ),
//                     const SizedBox(height: AppSpacings.lg),

//                     // Confirm Password
//                     PasswordTextField(
//                       hintText: loc.confirmPasswordHint,
//                       isObscured: state.isConfirmPasswordObscured,
//                       hasError: state.confirmPasswordError != AuthFieldError.none,
//                       onChanged: context.read<AuthBloc>().onConfirmPasswordChanged,
//                       onToggleVisibility:
//                           context.read<AuthBloc>().onToggleConfirmPasswordVisibility,
//                     ),
//                     if (state.confirmPasswordError != AuthFieldError.none)
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppSpacings.xs),
//                         child: Text(
//                           _errorText(loc, state.confirmPasswordError),
//                           style: AppTextStyles.timestamp,
//                         ),
//                       ),
                    
//                     const SizedBox(height: AppSpacings.section),
                    
//                     ElevatedButton(
//                       onPressed: state.isLoading 
//                         ? null 
//                         : context.read<AuthBloc>().onRegisterSubmit,
//                       child: state.isLoading
//                           ? const SizedBox(
//                               height: AppSpacings.xxl,
//                               width: AppSpacings.xxl,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             )
//                           : Text(loc.createAccount),
//                     ),
//                     const SizedBox(height: AppSpacings.xl),
//                     AuthFooterLink(
//                       leadingText: loc.alreadyHaveAccount,
//                       actionText: loc.signIn,
//                       onPressed: () => context.pop(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String _errorText(AppLocalizations loc, AuthFieldError error) {
//     switch (error) {
//       case AuthFieldError.invalidEmail:
//         return loc.invalidEmailError;
//       case AuthFieldError.requiredPassword:
//         return loc.passwordRequiredError;
//       case AuthFieldError.shortPassword:
//         return loc.passwordTooShortError;
//       case AuthFieldError.requiredDisplayName:
//         return loc.fieldRequiredError;
//       case AuthFieldError.passwordMismatch:
//         return loc.passwordMismatchError;
//       default:
//         return '';
//     }
//   }

//   String _failureText(AppLocalizations loc, AuthFailure failure) {
//     switch (failure) {
//       case AuthFailure.emailAlreadyInUse:
//         return loc.authEmailAlreadyInUse;
//       case AuthFailure.weakPassword:
//         return loc.authWeakPassword;
//       case AuthFailure.network:
//         return loc.authNetworkError;
//       case AuthFailure.unknown:
//         return loc.authUnknownError;
//       default:
//         return loc.authUnknownError;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/widgets/app_svg.dart';
// import '../bloc/auth_bloc.dart';
// import 'widgets/app_text_field.dart';
// import 'widgets/auth_footer_link.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final iconColor = isDark ? AppColors.darkNavActive : AppColors.navActive;

//     return BlocProvider(
//       create: (_) => AuthBloc(),
//       child: BlocConsumer<AuthBloc, AuthState>(
//         listenWhen: (previous, current) =>
//             previous.isResetLinkSent != current.isResetLinkSent ||
//             previous.failure != current.failure,
//         listener: (context, state) {
//           if (state.isResetLinkSent) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(loc.requestSent)),
//             );
//             context.pop();
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
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () => context.pop(),
//               ),
//             ),
//             extendBodyBehindAppBar: true,
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
//                     Center(
//                       child: Container(
//                         padding: const EdgeInsets.all(AppSpacings.xl),
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? AppColors.darkInputBackground
//                               : AppColors.inputBackground,
//                           shape: BoxShape.circle,
//                         ),
//                         child: AppSvg(
//                           assetPath: AssetPaths.protectedIcon,
//                           size: AppConstants.iconXl,
//                           color: iconColor,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: AppSpacings.xl),
//                     Text(
//                       loc.forgotPassword,
//                       style: AppTextStyles.authTitle,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: AppSpacings.sm),
//                     Text(
//                       loc.sendResetLink,
//                       style: AppTextStyles.authSubtitle,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: AppSpacings.xxl),
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
//                           _emailErrorText(loc, state.emailError),
//                           style: AppTextStyles.timestamp,
//                         ),
//                       ),
//                     const SizedBox(height: AppSpacings.section),
//                     ElevatedButton(
//                       onPressed: state.isLoading
//                           ? null
//                           : context.read<AuthBloc>().onForgotPasswordSubmit,
//                       child: state.isLoading
//                           ? const SizedBox(
//                               height: AppSpacings.xxl,
//                               width: AppSpacings.xxl,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             )
//                           : Text(loc.sendResetLink),
//                     ),
//                     const SizedBox(height: AppSpacings.xl),
//                     AuthFooterLink(
//                       leadingText: loc.rememberPassword,
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

//   String _emailErrorText(AppLocalizations loc, AuthFieldError error) {
//     switch (error) {
//       case AuthFieldError.invalidEmail:
//         return loc.invalidEmailError;
//       default:
//         return '';
//     }
//   }

//   String _failureText(AppLocalizations loc, AuthFailure failure) {
//     switch (failure) {
//       case AuthFailure.userNotFound:
//         return loc.authUserNotFound;
//       case AuthFailure.network:
//         return loc.authNetworkError;
//       case AuthFailure.unknown:
//         return loc.authUnknownError;
//       default:
//         return loc.authUnknownError;
//     }
//   }
// }

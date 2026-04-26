// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// // import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// // import 'package:chat_app/features/widgets/app_svg.dart';
// import '../../auth/ui/widgets/password_text_field.dart';
// import '../bloc/profile_bloc.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController _currentController = TextEditingController();
//   final TextEditingController _newController = TextEditingController();
//   final TextEditingController _confirmController = TextEditingController();

//   @override
//   void dispose() {
//     _currentController.dispose();
//     _newController.dispose();
//     _confirmController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => ProfileBloc(),
//       child: BlocConsumer<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state is ProfileUpdateSuccess) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(loc.passwordUpdatedSuccess)));
//             Navigator.of(context).pop();
//           }
//           if (state is ProfileError) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is ProfileLoading;
//           final loadedState = state is ProfileLoaded ? state : null;

//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 loc.changePasswordTitle,
//                 style: AppTextStyles.authTitle.copyWith(fontSize: 20),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: AppPaddings.screenHorizontal,
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 40),
//                   // Header Icon
//                   Container(
//                     width: 80,
//                     height: 80,
//                     // Header icon container background
//                     decoration: BoxDecoration(
//                       color: isDark
//                           ? AppColors.primary.withValues(
//                               alpha: 0.2,
//                             ) // slightly more visible in dark
//                           : AppColors.primary.withValues(alpha: 0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Center(
//                       child: Icon(
//                         Icons.lock_outline_rounded,
//                         size: 40,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   // Fields
//                   PasswordTextField(
//                     hintText: loc.currentPasswordHint,
//                     isObscured: loadedState?.isPasswordObscured ?? true,
//                     onChanged: (_) {},
//                     onToggleVisibility: () => context.read<ProfileBloc>().add(
//                       TogglePasswordVisibility(0),
//                     ),
//                   ),
//                   const SizedBox(height: AppSpacings.lg),
//                   PasswordTextField(
//                     hintText: loc.newPasswordHint,
//                     isObscured: loadedState?.isNewPasswordObscured ?? true,
//                     onChanged: (_) {},
//                     onToggleVisibility: () => context.read<ProfileBloc>().add(
//                       TogglePasswordVisibility(1),
//                     ),
//                   ),
//                   const SizedBox(height: AppSpacings.lg),
//                   PasswordTextField(
//                     hintText: loc.confirmNewPasswordHint,
//                     isObscured: loadedState?.isConfirmPasswordObscured ?? true,
//                     onChanged: (_) {},
//                     onToggleVisibility: () => context.read<ProfileBloc>().add(
//                       TogglePasswordVisibility(2),
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   // Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: isLoading
//                           ? null
//                           : () {
//                               context.read<ProfileBloc>().add(
//                                 UpdatePasswordPressed(
//                                   currentPassword: _currentController.text,
//                                   newPassword: _newController.text,
//                                   confirmPassword: _confirmController.text,
//                                 ),
//                               );
//                             },
//                       child: isLoading
//                           ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             )
//                           : Text(loc.updatePassword),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

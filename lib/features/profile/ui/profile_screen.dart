// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/profile_bloc.dart';
// import '../widgets/profile_action_tile.dart';
// import '../widgets/profile_info_card.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => ProfileBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(loc.profileTitle, style: AppTextStyles.authTitle.copyWith(fontSize: 20)),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is ProfileLoaded) {
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: AppPaddings.screenHorizontal),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     // Avatar Section
//                     Center(
//                       child: Column(
//                         children: [
//                           Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundColor: AppColors.primary.withValues(alpha: 0.1),
//                                 backgroundImage: state.avatarUrl != null
//                                     ? NetworkImage(state.avatarUrl!)
//                                     : const AssetImage(AssetPaths.avatarPlaceholder) as ImageProvider,
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   width: 24,
//                                   height: 24,
//                                   decoration: BoxDecoration(
//                                     color: state.isOnline ? AppColors.online : AppColors.textSecondary,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: isDark ? AppColors.darkSurface : AppColors.surface,
//                                       width: 3,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             state.displayName,
//                             style: AppTextStyles.authTitle.copyWith(fontSize: 22),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             state.email,
//                             style: AppTextStyles.timestamp.copyWith(
//                               fontSize: 14,
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: AppColors.primary.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               state.accountType == 'Premium' ? loc.accountTypePremium : loc.accountTypeStandard,
//                               style: TextStyle(
//                                 color: AppColors.primary,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 32),
                    
//                     // Info Card
//                     ProfileInfoCard(
//                       displayName: state.displayName,
//                       email: state.email,
//                       username: state.username,
//                     ),
//                     const SizedBox(height: 24),

//                     // Actions
//                     ProfileActionTile(
//                       icon: Icons.lock_outline_rounded,
//                       title: loc.changePasswordTitle,
//                       onTap: () {},
//                     ),
//                     ProfileActionTile(
//                       icon: Icons.settings_outlined,
//                       title: loc.settingsTitle,
//                       onTap: () {},
//                     ),
//                     ProfileActionTile(
//                       icon: Icons.logout_rounded,
//                       title: loc.signOut,
//                       textColor: AppColors.error,
//                       iconColor: AppColors.error,
//                       onTap: () => context.read<ProfileBloc>().add(SignOutPressed()),
//                     ),
//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               );
//             }

//             if (state is ProfileError) {
//               final errorMessage = state.message == 'passwordMismatchError' 
//                   ? loc.passwordMismatchError 
//                   : state.message;
//               return Center(child: Text(errorMessage));
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/find_friends_bloc.dart';

// class FindPersonTile extends StatelessWidget {
//   final UserSearchResult user;
//   final VoidCallback onAddFriend;

//   const FindPersonTile({
//     super.key,
//     required this.user,
//     required this.onAddFriend,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Row(
//         children: [
//           // Avatar
//           CircleAvatar(
//             radius: AppConstants.avatarMd / 2,
//             backgroundColor: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//             backgroundImage: user.avatarUrl != null 
//                 ? NetworkImage(user.avatarUrl!) 
//                 : const AssetImage(AssetPaths.avatarPlaceholder) as ImageProvider,
//           ),
//           const SizedBox(width: 12),
          
//           // User Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   user.name,
//                   style: AppTextStyles.chatName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   user.email,
//                   style: AppTextStyles.chatPreview,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
          
//           // Add Friend Button
//           if (!user.isFriend)
//             SizedBox(
//               height: 32,
//               child: ElevatedButton(
//                 onPressed: onAddFriend,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: AppColors.onPrimary,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Text(
//                   loc.addFriend,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             )
//           else
//             const Icon(
//               Icons.check_circle,
//               color: AppColors.primary,
//               size: 24,
//             ),
//         ],
//       ),
//     );
//   }
// }

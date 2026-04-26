// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import '../bloc/chats_bloc.dart';

// class ChatTile extends StatelessWidget {
//   final ChatPreview chat;
//   final VoidCallback onTap;

//   const ChatTile({
//     super.key,
//     required this.chat,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final timeStr = _formatTimestamp(chat.timestamp);

//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         constraints: const BoxConstraints(minHeight: 72),
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppPaddings.screenHorizontal,
//           vertical: 8, // Fixed padding for list tile vertical
//         ),
//         child: Row(
//           children: [
//             // Avatar
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: AppConstants.avatarMd / 2 + 10, // Adjusted for design
//                   backgroundColor: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//                   backgroundImage: chat.avatarUrl != null 
//                       ? NetworkImage(chat.avatarUrl!) 
//                       : const AssetImage(AssetPaths.avatarPlaceholder) as ImageProvider,
//                 ),
//                 if (chat.isActive)
//                   Positioned(
//                     right: 2,
//                     bottom: 2,
//                     child: Container(
//                       width: 12,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: AppColors.online,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: isDark ? AppColors.darkSurface : AppColors.surface,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             // Text Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     chat.name,
//                     style: AppTextStyles.chatName,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     chat.lastMessage,
//                     style: AppTextStyles.chatPreview,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),
//             // Right Column: Time + Badge
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   timeStr,
//                   style: AppTextStyles.timestamp,
//                 ),
//                 const SizedBox(height: 8),
//                 if (chat.unreadCount > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: AppColors.primary,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     constraints: const BoxConstraints(minWidth: 20),
//                     alignment: Alignment.center,
//                     child: Text(
//                       chat.unreadCount > 99 ? '99+' : chat.unreadCount.toString(),
//                       style: AppTextStyles.timestamp.copyWith(
//                         color: AppColors.onPrimary,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 10,
//                       ),
//                     ),
//                   )
//                 else
//                   const SizedBox(height: 16), // Placeholder to maintain height
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inDays == 0) {
//       return DateFormat.Hm().format(timestamp);
//     } else if (difference.inDays < 7) {
//       return DateFormat.E().format(timestamp);
//     } else {
//       return DateFormat.yMd().format(timestamp);
//     }
//   }
// }

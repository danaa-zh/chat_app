// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../core/constants/app_constants.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/friend_requests_bloc.dart';

// class FriendRequestTile extends StatelessWidget {
//   final FriendRequest request;
//   final VoidCallback? onAccept;
//   final VoidCallback? onDecline;
//   final VoidCallback? onCancel;

//   const FriendRequestTile({
//     super.key,
//     required this.request,
//     this.onAccept,
//     this.onDecline,
//     this.onCancel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final timeStr = DateFormat.Md().add_Hm().format(request.timestamp);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Avatar
//               CircleAvatar(
//                 radius: AppConstants.avatarMd / 2,
//                 backgroundColor: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//                 backgroundImage: request.avatarUrl != null 
//                     ? NetworkImage(request.avatarUrl!) 
//                     : const AssetImage(AssetPaths.avatarPlaceholder) as ImageProvider,
//               ),
//               const SizedBox(width: 12),
              
//               // Info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       request.name,
//                       style: AppTextStyles.chatName,
//                     ),
//                     Text(
//                       request.email,
//                       style: AppTextStyles.chatPreview,
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Time
//               Text(
//                 timeStr,
//                 style: AppTextStyles.timestamp,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
          
//           // Actions or Status
//           if (request.isReceived && request.status == RequestStatus.pending)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 _CompactButton(
//                   label: loc.decline,
//                   onPressed: onDecline,
//                   isOutlined: true,
//                   isError: true,
//                 ),
//                 const SizedBox(width: 8),
//                 _CompactButton(
//                   label: loc.accept,
//                   onPressed: onAccept,
//                 ),
//               ],
//             )
//           else if (!request.isReceived)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 _StatusBadge(status: request.status, loc: loc),
//                 if (request.status == RequestStatus.pending) ...[
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: const Icon(Icons.close, size: 20, color: AppColors.error),
//                     onPressed: onCancel,
//                     visualDensity: VisualDensity.compact,
//                   ),
//                 ],
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _CompactButton extends StatelessWidget {
//   final String label;
//   final VoidCallback? onPressed;
//   final bool isOutlined;
//   final bool isError;

//   const _CompactButton({
//     required this.label,
//     this.onPressed,
//     this.isOutlined = false,
//     this.isError = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (isOutlined) {
//       return SizedBox(
//         height: 32,
//         child: OutlinedButton(
//           onPressed: onPressed,
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(
//               color: isError ? AppColors.error.withValues(alpha: 0.5) : AppColors.outline,
//             ),
//             foregroundColor: isError ? AppColors.error : AppColors.textSecondary,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//         ),
//       );
//     }

//     return SizedBox(
//       height: 32,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: AppColors.onPrimary,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 0,
//         ),
//         child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//       ),
//     );
//   }
// }

// class _StatusBadge extends StatelessWidget {
//   final RequestStatus status;
//   final AppLocalizations loc;

//   const _StatusBadge({required this.status, required this.loc});

//   @override
//   Widget build(BuildContext context) {
//     final color = status == RequestStatus.accepted 
//         ? AppColors.online 
//         : (status == RequestStatus.declined ? AppColors.error : AppColors.textSecondary);
    
//     final label = status == RequestStatus.accepted 
//         ? loc.accepted 
//         : (status == RequestStatus.pending ? loc.pending : loc.declined);

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: color,
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }

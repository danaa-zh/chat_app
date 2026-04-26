// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/notifications_bloc.dart';

// class NotificationTile extends StatelessWidget {
//   final AppNotification notification;
//   final VoidCallback onDismiss;

//   const NotificationTile({
//     super.key,
//     required this.notification,
//     required this.onDismiss,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final timeStr = DateFormat.Md().add_Hm().format(notification.timestamp);

//     final title = _getNotificationTitle(loc, notification.type);
//     final description = _getNotificationDescription(loc, notification);

//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//       color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant.withValues(alpha: 0.5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Icon area
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: _getIconBgColor(notification.type, isDark),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _getIconData(notification.type),
//                 size: 20,
//                 color: _getIconColor(notification.type, isDark),
//               ),
//             ),
//             const SizedBox(width: 12),
            
//             // Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: AppTextStyles.chatName.copyWith(fontSize: 14),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     description,
//                     style: AppTextStyles.chatPreview.copyWith(fontSize: 13),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     timeStr,
//                     style: AppTextStyles.timestamp.copyWith(fontSize: 11),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Dismiss
//             IconButton(
//               icon: const Icon(Icons.close, size: 18),
//               onPressed: onDismiss,
//               visualDensity: VisualDensity.compact,
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(),
//               color: AppColors.textSecondary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getNotificationTitle(AppLocalizations loc, NotificationType type) {
//     switch (type) {
//       case NotificationType.welcome:
//         return loc.notificationWelcomeTitle;
//       case NotificationType.requestAccepted:
//         return loc.notificationRequestAcceptedTitle;
//       case NotificationType.newRequest:
//         return loc.notificationNewRequestTitle;
//       case NotificationType.reminder:
//         return loc.notificationReminderTitle;
//       case NotificationType.systemUpdate:
//         return loc.notificationSystemUpdateTitle;
//     }
//   }

//   String _getNotificationDescription(AppLocalizations loc, AppNotification notification) {
//     final name = notification.data ?? 'Someone';
//     switch (notification.type) {
//       case NotificationType.welcome:
//         return loc.notificationWelcomeDesc;
//       case NotificationType.requestAccepted:
//         return loc.notificationRequestAcceptedDesc(name);
//       case NotificationType.newRequest:
//         return loc.notificationNewRequestDesc(name);
//       case NotificationType.reminder:
//         return loc.notificationReminderDesc;
//       case NotificationType.systemUpdate:
//         return loc.notificationSystemUpdateDesc;
//     }
//   }

//   IconData _getIconData(NotificationType type) {
//     switch (type) {
//       case NotificationType.welcome:
//         return Icons.celebration;
//       case NotificationType.requestAccepted:
//         return Icons.person_add_alt_1;
//       case NotificationType.newRequest:
//         return Icons.person_add;
//       case NotificationType.reminder:
//         return Icons.notifications_active;
//       case NotificationType.systemUpdate:
//         return Icons.system_update;
//     }
//   }

//   Color _getIconBgColor(NotificationType type, bool isDark) {
//     switch (type) {
//       case NotificationType.welcome:
//         return isDark ? AppColors.primary.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.1);
//       case NotificationType.requestAccepted:
//         return isDark ? Colors.green.withValues(alpha: .2) : Colors.green.withValues(alpha: 0.1);
//       case NotificationType.systemUpdate:
//         return isDark ? AppColors.secondary.withValues(alpha: 0.2) : AppColors.secondary.withValues(alpha: 0.1);
//       default:
//         return isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant;
//     }
//   }

//   Color _getIconColor(NotificationType type, bool isDark) {
//     switch (type) {
//       case NotificationType.welcome:
//         return AppColors.primary;
//       case NotificationType.requestAccepted:
//         return Colors.green;
//       case NotificationType.systemUpdate:
//         return AppColors.secondary;
//       default:
//         return AppColors.textSecondary;
//     }
//   }
// }

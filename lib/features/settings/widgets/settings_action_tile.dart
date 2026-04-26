// import 'package:flutter/material.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';

// class SettingsActionTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String? subtitle;
//   final VoidCallback onTap;
//   final Color? textColor;

//   const SettingsActionTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.subtitle,
//     required this.onTap,
//     this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkSurfaceVariant : AppColors.surface,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ListTile(
//         onTap: onTap,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         leading: Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: AppColors.primary.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               size: 18,
//               color: AppColors.primary,
//             ),
//           ),
//         ),
//         title: Text(
//           title,
//           style: AppTextStyles.chatName.copyWith(
//             fontSize: 15,
//             color: textColor ?? AppColors.textPrimary,
//           ),
//         ),
//         subtitle: subtitle != null
//             ? Text(
//                 subtitle!,
//                 style: AppTextStyles.timestamp.copyWith(fontSize: 12),
//               )
//             : null,
//         trailing: Icon(
//           Icons.chevron_right_rounded,
//           color: AppColors.textSecondary.withValues(alpha: 0.3),
//         ),
//       ),
//     );
//   }
// }

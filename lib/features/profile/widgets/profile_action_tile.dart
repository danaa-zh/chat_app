// import 'package:flutter/material.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';

// class ProfileActionTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//   final Color? textColor;
//   final Color? iconColor;

//   const ProfileActionTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//     this.textColor,
//     this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkSurfaceVariant : AppColors.surface,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: isDark ? null : [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ListTile(
//         onTap: onTap,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         leading: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               size: 20,
//               color: iconColor ?? AppColors.primary,
//             ),
//           ),
//         ),
//         title: Text(
//           title,
//           style: AppTextStyles.chatName.copyWith(
//             fontSize: 16,
//             color: textColor ?? AppColors.textPrimary,
//           ),
//         ),
//         trailing: Icon(
//           Icons.chevron_right_rounded,
//           color: AppColors.textSecondary.withValues(alpha: 0.5),
//         ),
//       ),
//     );
//   }
// }

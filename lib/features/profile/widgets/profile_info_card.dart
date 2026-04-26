// import 'package:flutter/material.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';

// class ProfileInfoCard extends StatelessWidget {
//   final String displayName;
//   final String email;
//   final String? username;

//   const ProfileInfoCard({
//     super.key,
//     required this.displayName,
//     required this.email,
//     this.username,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkSurfaceVariant : AppColors.surface,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: isDark ? null : [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             loc.personalInfo,
//             style: AppTextStyles.authTitle.copyWith(fontSize: 18),
//           ),
//           const SizedBox(height: 20),
//           _InfoRow(
//             label: loc.fullName,
//             value: displayName,
//           ),
//           const Divider(height: 32),
//           _InfoRow(
//             label: loc.email,
//             value: email,
//           ),
//           if (username != null) ...[
//             const Divider(height: 32),
//             _InfoRow(
//               label: loc.username,
//               value: username!,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoRow({
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: AppTextStyles.timestamp.copyWith(
//             color: AppColors.textSecondary,
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: AppTextStyles.chatPreview.copyWith(
//             color: AppColors.textPrimary,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

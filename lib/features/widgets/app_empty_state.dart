// import 'package:flutter/material.dart';
// // import '../core/constants/app_constants.dart';
// import 'package:chat_app/core/constants/app_paddings.dart';
// import 'package:chat_app/core/constants/app_spacings.dart';
// import 'package:chat_app/core/theme/app_colors.dart';
// import 'package:chat_app/core/theme/app_text_styles.dart';
// import 'package:chat_app/features/widgets/app_svg.dart';

// class AppEmptyState extends StatelessWidget {
//   final String iconPath;
//   final String title;
//   final String subtitle;
//   final String? primaryActionLabel;
//   final VoidCallback? onPrimaryAction;
//   final String? secondaryActionLabel;
//   final VoidCallback? onSecondaryAction;

//   const AppEmptyState({
//     super.key,
//     required this.iconPath,
//     required this.title,
//     required this.subtitle,
//     this.primaryActionLabel,
//     this.onPrimaryAction,
//     this.secondaryActionLabel,
//     this.onSecondaryAction,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Center(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(AppPaddings.screenHorizontal),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon in soft circular background
//             Container(
//               width: 100, // Size for circular background
//               height: 100,
//               decoration: BoxDecoration(
//                 color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: AppSvg(
//                   assetPath: iconPath,
//                   size: 48, // Icon size
//                   color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppSpacings.block),
            
//             // Texts
//             Text(
//               title,
//               style: AppTextStyles.emptyTitle,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               subtitle,
//               style: AppTextStyles.emptySubtitle,
//               textAlign: TextAlign.center,
//             ),
            
//             // Actions
//             if (primaryActionLabel != null || secondaryActionLabel != null) ...[
//               const SizedBox(height: AppSpacings.screen),
//               if (primaryActionLabel != null)
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: onPrimaryAction,
//                     child: Text(primaryActionLabel!),
//                   ),
//                 ),
//               if (secondaryActionLabel != null) ...[
//                 const SizedBox(height: AppSpacings.sm),
//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton(
//                     onPressed: onSecondaryAction,
//                     child: Text(secondaryActionLabel!),
//                   ),
//                 ),
//               ],
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

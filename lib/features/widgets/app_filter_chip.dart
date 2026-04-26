// import 'package:flutter/material.dart';
// import 'package:chat_app/core/constants/app_constants.dart';
// import 'package:chat_app/core/theme/app_colors.dart';
// import 'package:chat_app/core/theme/app_text_styles.dart';

// class AppFilterChip extends StatelessWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const AppFilterChip({
//     super.key,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     final backgroundColor = isSelected
//         ? (isDark ? AppColors.darkChipSelected : AppColors.primary)
//         : (isDark ? AppColors.darkChipUnselected : AppColors.surfaceVariant);

//     final textColor = isSelected
//         ? (isDark ? AppColors.darkTextPrimary : AppColors.onPrimary)
//         : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary);

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 6,
//         ),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(AppConstants.radiusPill),
//           border: !isSelected
//               ? Border.all(
//                   color: isDark ? AppColors.darkOutline : AppColors.outline,
//                   width: AppConstants.defaultBorderWidth,
//                 )
//               : null,
//         ),
//         child: Text(
//           label,
//           style: AppTextStyles.inputText.copyWith(
//             color: textColor,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }
// }

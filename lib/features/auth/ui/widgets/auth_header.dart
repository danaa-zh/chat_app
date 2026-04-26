// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/constants/app_spacings.dart';
// import '../../../../core/constants/asset_paths.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/features/widgets/app_svg.dart';

// class AuthHeader extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   const AuthHeader({
//     super.key,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final iconColor = isDark ? AppColors.darkNavActive : AppColors.navActive;
//     final subtitleColor =
//         isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

//     return Column(
//       children: [
//         Container(
//           width: AppConstants.splashLogoSize,
//           height: AppConstants.splashLogoSize,
//           decoration: BoxDecoration(
//             color: iconColor.withValues(alpha: 0.14),
//             borderRadius: BorderRadius.circular(AppConstants.radiusLg),
//           ),
//           child: Center(
//             child: AppSvg(
//               assetPath: AssetPaths.chatsIcon,
//               size: AppConstants.iconXl,
//               color: iconColor,
//             ),
//           ),
//         ),
//         const SizedBox(height: AppSpacings.block),
//         Text(
//           title,
//           style: AppTextStyles.authTitle,
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: AppSpacings.sm),
//         Text(
//           subtitle,
//           style: AppTextStyles.authSubtitle.copyWith(color: subtitleColor),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }

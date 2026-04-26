// import 'package:flutter/material.dart';
// import 'package:chat_app/core/constants/app_constants.dart';
// import 'package:chat_app/core/constants/asset_paths.dart';
// import 'package:chat_app/core/theme/app_colors.dart';
// import 'package:chat_app/core/theme/app_text_styles.dart';
// import 'app_svg.dart';

// class AppSearchField extends StatelessWidget {
//   final String hintText;
//   final ValueChanged<String>? onChanged;
//   final TextEditingController? controller;

//   const AppSearchField({
//     super.key,
//     required this.hintText,
//     this.onChanged,
//     this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       height: AppConstants.defaultInputHeight,
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkInputBackground : AppColors.inputBackground,
//         borderRadius: BorderRadius.circular(AppConstants.radiusMd),
//       ),
//       child: TextField(
//         controller: controller,
//         onChanged: onChanged,
//         style: AppTextStyles.inputText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: AppTextStyles.inputHint,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(10), // md spacing
//             child: AppSvg(
//               assetPath: AssetPaths.searchIcon,
//               size: AppConstants.iconMd,
//               color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
//             ),
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: (AppConstants.defaultInputHeight - 20) / 2,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/features/widgets/app_svg.dart';

// class AppTextField extends StatelessWidget {
//   final String hintText;
//   final String iconPath;
//   final bool hasError;
//   final ValueChanged<String> onChanged;
//   final TextInputType keyboardType;

//   const AppTextField({
//     super.key,
//     required this.hintText,
//     required this.iconPath,
//     required this.onChanged,
//     this.hasError = false,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final iconColor = isDark ? AppColors.darkNavActive : AppColors.navActive;

//     return SizedBox(
//       height: AppConstants.defaultInputHeight,
//       child: TextField(
//         keyboardType: keyboardType,
//         onChanged: onChanged,
//         style: AppTextStyles.inputText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: AppTextStyles.inputHint,
//           errorText: hasError ? '' : null,
//           errorStyle: const TextStyle(height: 0, fontSize: 0),
//           fillColor:
//               isDark ? AppColors.darkInputBackground : AppColors.inputBackground,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(AppConstants.iconSm),
//             child: AppSvg(
//               assetPath: iconPath,
//               size: AppConstants.iconMd,
//               color: iconColor,
//             ),
//           ),
//           prefixIconConstraints: const BoxConstraints(
//             minWidth: AppConstants.defaultInputHeight,
//             minHeight: AppConstants.defaultInputHeight,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.radiusLg),
//             borderSide: BorderSide(
//               color: isDark ? AppColors.darkOutline : AppColors.outline,
//               width: AppConstants.defaultBorderWidth,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.radiusLg),
//             borderSide: const BorderSide(
//               color: AppColors.primary,
//               width: AppConstants.defaultBorderWidth,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.radiusLg),
//             borderSide: const BorderSide(
//               color: AppColors.error,
//               width: AppConstants.defaultBorderWidth,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.radiusLg),
//             borderSide: const BorderSide(
//               color: AppColors.error,
//               width: AppConstants.defaultBorderWidth,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

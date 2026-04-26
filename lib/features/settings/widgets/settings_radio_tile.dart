// import 'package:flutter/material.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';

// class SettingsRadioTile<T> extends StatelessWidget {
//   final String title;
//   final T value;
//   final T groupValue;
//   final ValueChanged<T?> onChanged;

//   const SettingsRadioTile({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.groupValue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isSelected = value == groupValue;

//     return RadioGroup<T>(
//       groupValue: groupValue,
//       onChanged: onChanged,
//       child: ListTile(
//         onTap: () => onChanged(value),
//         title: Text(
//           title,
//           style: AppTextStyles.chatName.copyWith(
//             fontSize: 16,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//           ),
//         ),
//         trailing: Radio<T>(
//           value: value,
//           activeColor: AppColors.primary,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../../core/theme/app_text_styles.dart';

// class SettingsSection extends StatelessWidget {
//   final String title;
//   final List<Widget> children;

//   const SettingsSection({
//     super.key,
//     required this.title,
//     required this.children,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//           child: Text(
//             title,
//             style: AppTextStyles.authTitle.copyWith(
//               fontSize: 14,
//               color: Theme.of(context).primaryColor,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         ...children,
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

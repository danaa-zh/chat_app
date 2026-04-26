// import 'package:flutter/material.dart';
// import '../../../core/constants/app_paddings.dart';
// // import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// // import 'package:chat_app/features/widgets/app_svg.dart';

// class ChatInputBar extends StatefulWidget {
//   final Function(String) onSend;

//   const ChatInputBar({
//     super.key,
//     required this.onSend,
//   });

//   @override
//   State<ChatInputBar> createState() => _ChatInputBarState();
// }

// class _ChatInputBarState extends State<ChatInputBar> {
//   final TextEditingController _controller = TextEditingController();
//   bool _hasText = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       setState(() {
//         _hasText = _controller.text.trim().isNotEmpty;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handleSend() {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       widget.onSend(text);
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppPaddings.screenHorizontal,
//         vertical: 12,
//       ),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkSurface : AppColors.surface,
//         border: Border(
//           top: BorderSide(
//             color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
//           ),
//         ),
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant.withValues(alpha: 0.5),
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: TextField(
//                   controller: _controller,
//                   maxLines: 4,
//                   minLines: 1,
//                   decoration: InputDecoration(
//                     hintText: loc.typeMessage,
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     hintStyle: TextStyle(
//                       color: AppColors.textSecondary.withValues(alpha: 0.6),
//                       fontSize: 15,
//                     ),
//                   ),
//                   onSubmitted: (_) => _handleSend(),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             GestureDetector(
//               onTap: _hasText ? _handleSend : null,
//               child: Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: _hasText ? AppColors.primary : (isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.send_rounded,
//                     color: _hasText ? AppColors.onPrimary : AppColors.textSecondary,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

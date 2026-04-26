// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import '../bloc/chat_bloc.dart';

// class MessageBubble extends StatelessWidget {
//   final Message message;

//   const MessageBubble({
//     super.key,
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final timeStr = DateFormat.Hm().format(message.timestamp);

//     return Align(
//       alignment: message.isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         decoration: BoxDecoration(
//           color: message.isOutgoing 
//               ? AppColors.outgoingMessage 
//               : (isDark ? AppColors.darkSurfaceVariant : AppColors.incomingMessage),
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//             bottomLeft: Radius.circular(message.isOutgoing ? 16 : 4),
//             bottomRight: Radius.circular(message.isOutgoing ? 4 : 16),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               message.text,
//               style: AppTextStyles.chatPreview.copyWith(
//                 color: AppColors.textPrimary,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   timeStr,
//                   style: AppTextStyles.timestamp.copyWith(
//                     fontSize: 10,
//                     color: AppColors.textSecondary.withValues(alpha: 0.7),
//                   ),
//                 ),
//                 if (message.isOutgoing) ...[
//                   const SizedBox(width: 4),
//                   Icon(
//                     message.isRead ? Icons.done_all : Icons.done,
//                     size: 14,
//                     color: message.isRead ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.7),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

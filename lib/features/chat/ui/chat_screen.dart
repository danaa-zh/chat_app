// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import '../bloc/chat_bloc.dart';
// import '../widgets/chat_input_bar.dart';
// import '../widgets/message_bubble.dart';

// class ChatScreen extends StatelessWidget {
//   final String chatId;

//   const ChatScreen({
//     super.key,
//     required this.chatId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (_) => ChatBloc()..add(LoadMessages(chatId)),
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           titleSpacing: 0,
//           title: BlocBuilder<ChatBloc, ChatState>(
//             builder: (context, state) {
//               if (state is ChatLoaded) {
//                 return Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 18,
//                       backgroundImage: state.contact.avatarUrl != null
//                           ? NetworkImage(state.contact.avatarUrl!)
//                           : const AssetImage(AssetPaths.avatarPlaceholder) as ImageProvider,
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           state.contact.name,
//                           style: AppTextStyles.chatName.copyWith(fontSize: 16),
//                         ),
//                         Text(
//                           state.contact.isOnline ? loc.online : loc.offline,
//                           style: AppTextStyles.timestamp.copyWith(
//                             color: state.contact.isOnline ? AppColors.online : AppColors.textSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//           backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
//           elevation: 0.5,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.more_vert),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   if (state is ChatLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (state is ChatLoaded) {
//                     return ListView.builder(
//                       reverse: true,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       itemCount: state.messages.length,
//                       itemBuilder: (context, index) {
//                         return MessageBubble(message: state.messages[index]);
//                       },
//                     );
//                   }

//                   if (state is ChatError) {
//                     return Center(child: Text(loc.failedToLoadMessages));
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//             ChatInputBar(
//               onSend: (text) {
//                 context.read<ChatBloc>().add(SendMessagePressed(text));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

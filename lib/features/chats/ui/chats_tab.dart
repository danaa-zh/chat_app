// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/constants/app_spacings.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import 'package:chat_app/l10n/generated/app_localizations.dart';
// import 'package:chat_app/features/widgets/app_empty_state.dart';
// import 'package:chat_app/features/widgets/app_filter_chip.dart';
// import 'package:chat_app/features/widgets/app_search_field.dart';
// import '../../../core/constants/asset_paths.dart';
// import '../bloc/chats_bloc.dart';
// import '../widgets/chat_tile.dart';

// class MainTab extends StatelessWidget {
//   const MainTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return BlocProvider(
//       create: (context) => ChatsBloc()..loadChats(),
//       child: Scaffold(
//         backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
//         appBar: AppBar(
//           title: Text(
//             loc.chatsTitle,
//             style: AppTextStyles.appBarTitle,
//           ),
//           centerTitle: true, // Left/center according to system consistency
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           scrolledUnderElevation: 0,
//         ),
//         body: BlocBuilder<ChatsBloc, ChatsState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 // Search Field
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppPaddings.screenHorizontal,
//                     vertical: AppSpacings.sm,
//                   ),
//                   child: AppSearchField(
//                     hintText: loc.searchConversations,
//                     onChanged: (query) => context.read<ChatsBloc>().updateSearch(query),
//                   ),
//                 ),
                
//                 // Filter Chips Row
//                 SizedBox(
//                   height: 48,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: AppPaddings.screenHorizontal,
//                     ),
//                     children: [
//                       AppFilterChip(
//                         label: loc.filterAll,
//                         isSelected: state is ChatsLoaded ? state.filter == ChatsFilter.all : true,
//                         onTap: () => context.read<ChatsBloc>().updateFilter(ChatsFilter.all),
//                       ),
//                       const SizedBox(width: AppSpacings.sm),
//                       AppFilterChip(
//                         label: loc.filterUnread,
//                         isSelected: state is ChatsLoaded ? state.filter == ChatsFilter.unread : false,
//                         onTap: () => context.read<ChatsBloc>().updateFilter(ChatsFilter.unread),
//                       ),
//                       const SizedBox(width: AppSpacings.sm),
//                       AppFilterChip(
//                         label: loc.filterRequest,
//                         isSelected: state is ChatsLoaded ? state.filter == ChatsFilter.request : false,
//                         onTap: () => context.read<ChatsBloc>().updateFilter(ChatsFilter.request),
//                       ),
//                       const SizedBox(width: AppSpacings.sm),
//                       AppFilterChip(
//                         label: loc.filterActive,
//                         isSelected: state is ChatsLoaded ? state.filter == ChatsFilter.active : false,
//                         onTap: () => context.read<ChatsBloc>().updateFilter(ChatsFilter.active),
//                       ),
//                     ],
//                   ),
//                 ),
                
//                 const SizedBox(height: AppSpacings.sm),

//                 // Content
//                 Expanded(
//                   child: _buildContent(context, state, loc),
//                 ),
//               ],
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             // New chat logic
//           },
//           backgroundColor: AppColors.primary,
//           foregroundColor: AppColors.onPrimary,
//           icon: const Icon(Icons.add),
//           label: Text(
//             loc.newChat,
//             style: AppTextStyles.button.copyWith(color: AppColors.onPrimary),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(BuildContext context, ChatsState state, AppLocalizations loc) {
//     if (state is ChatsLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     if (state is ChatsError) {
//       return Center(
//         child: Text(loc.failedToLoadChats),
//       );
//     }

//     if (state is ChatsEmpty) {
//       return AppEmptyState(
//         iconPath: AssetPaths.chatsIcon,
//         title: loc.noChatsFound,
//         subtitle: loc.noConversationsDescription,
//         primaryActionLabel: loc.findPeople,
//         onPrimaryAction: () {
//           // Find people logic
//         },
//         secondaryActionLabel: loc.viewFriends,
//         onSecondaryAction: () {
//           // View friends logic
//         },
//       );
//     }

//     if (state is ChatsLoaded) {
//       final chats = state.filteredChats;

//       if (chats.isEmpty) {
//         return Center(
//           child: Text(
//             state.searchQuery.isEmpty ? loc.noConversationsYet : loc.noConversationsYet,
//             style: AppTextStyles.chatPreview,
//           ),
//         );
//       }

//       return ListView.separated(
//         itemCount: chats.length,
//         padding: const EdgeInsets.only(bottom: 80), // Padding for FAB
//         separatorBuilder: (context, index) => const Divider(
//           height: 1,
//           indent: AppPaddings.screenHorizontal + 60, // Align with text
//           color: AppColors.divider,
//         ),
//         itemBuilder: (context, index) {
//           final chat = chats[index];
//           return ChatTile(
//             chat: chat,
//             onTap: () {
//               // Open chat
//             },
//           );
//         },
//       );
//     }

//     return const SizedBox.shrink();
//   }
// }

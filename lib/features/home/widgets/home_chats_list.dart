import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/widgets/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChatsList extends StatelessWidget {
  const HomeChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.block),
          topRight: Radius.circular(AppRadius.block),
        ),
      ),
      child: Column(
        children: [
          if (!controller.isSearching || controller.searchQuery.isEmpty)
            _ChatHeader(controller: controller),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: controller.searchQuery.isEmpty
                    ? AppSpacings.sm
                    : AppSpacings.block,
                horizontal: AppPaddings.block,
              ),
              itemCount: controller.chats.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.grey[200],
                indent: AppConstants.urlImageSize,
              ),
              itemBuilder: (_, index) {
                final chat = controller.chats[index];
                final otherUser = controller.getOtherUser(chat);
                if (otherUser == null) return const SizedBox.shrink();

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: ChatListItem(
                    chat: chat,
                    otherUser: otherUser,
                    lastMessageTime: controller.formatLastMessageTime(
                      chat.lastMessageTime,
                    ),
                    onTap: () => controller.openChat(chat),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final HomeController controller;
  const _ChatHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPaddings.block,
        AppPaddings.block,
        AppPaddings.block,
        AppPaddings.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            String title = context.loc.recentChatsHeader;
            switch (controller.activeFilter) {
              case 'Unread':
                title = context.loc.unreadMessagesHeader;
                break;
              case 'Recent':
                title = context.loc.recentMessagesHeader;
                break;
              case 'Active':
                title = context.loc.activeMessagesHeader;
                break;
            }
            return Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            );
          }),
          if (controller.activeFilter != 'All')
            TextButton(
              onPressed: controller.clearAllFilters,
              child: Text(
                context.loc.clearFilter,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/chat_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ChatController controller;
  final String chatId;

  const ChatAppBar({super.key, required this.controller, required this.chatId});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    final chatLabel = context.loc.chat;
    final onlineLabel = context.loc.online;
    final offlineLabel = context.loc.offline;
    final deleteChatLabel = context.loc.deleteChat;

    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Obx(() {
        final otherUser = widget.controller.otherUser;
        if (otherUser == null) return Text(chatLabel);
        return Row(
          children: [
            CircleAvatar(
              radius: AppRadius.md,
              backgroundColor: AppColors.primary,
              child: otherUser.photoURL.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        otherUser.photoURL,
                        width: AppConstants.urlImageSize,
                        height: AppConstants.urlImageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Text(
                          otherUser.displayName.isNotEmpty
                              ? otherUser.displayName[0].toUpperCase()
                              : '?',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    )
                  : Text(
                      otherUser.displayName.isNotEmpty
                          ? otherUser.displayName[0].toUpperCase()
                          : '?',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: AppSpacings.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser.displayName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    otherUser.isOnline ? onlineLabel : offlineLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: otherUser.isOnline
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') widget.controller.deleteChat();
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: AppColors.error),
                  const SizedBox(width: AppSpacings.sm),
                  Text(deleteChatLabel),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

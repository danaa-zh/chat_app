import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel chat;
  final UserModel otherUser;
  final String lastMessageTime;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.otherUser,
    required this.lastMessageTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final homeController = Get.find<HomeController>();
    final currentUserId = authController.user?.uid ?? '';
    final unreadCount = chat.getUserCount(currentUserId);

    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: () => _showChatOptions(context, homeController),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Row(
            children: [
              _ChatAvatar(user: otherUser),
              const SizedBox(width: AppSpacings.lg),
              Expanded(
                child: _ChatInfo(
                  chat: chat,
                  otherUser: otherUser,
                  lastMessageTime: lastMessageTime,
                  currentUserId: currentUserId,
                  unreadCount: unreadCount,
                ),
              ),
              if (unreadCount > 0) _UnreadBadge(unreadCount: unreadCount),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatOptions(BuildContext context, HomeController homeController) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppPaddings.lg),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.section),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppConstants.dragHandleWidth,
              height: AppConstants.dragHandleHeight,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
            ),
            const SizedBox(height: AppSpacings.lg),
            ListTile(
              leading: Icon(Icons.delete_outline, color: AppColors.error),
              title: Text(context.loc.deleteChat),
              subtitle: Text(context.loc.deleteChatSubtitle),
              onTap: () {
                Get.back();
                homeController.deleteChat(chat);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: AppColors.primary),
              title: Text(context.loc.viewProfile),
              onTap: () {
                Get.back();
                // navigate to user profile
              },
            ),
            const SizedBox(height: AppSpacings.md),
          ],
        ),
      ),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────

class _ChatAvatar extends StatelessWidget {
  final UserModel user;

  const _ChatAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: AppConstants.avatarRadius,
          backgroundColor: AppColors.primary,
          child: user.photoURL.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    user.photoURL,
                    width: AppConstants.urlImageSize,
                    height: AppConstants.urlImageSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _AvatarInitial(displayName: user.displayName),
                  ),
                )
              : _AvatarInitial(displayName: user.displayName),
        ),
        if (user.isOnline) const _OnlineIndicator(),
      ],
    );
  }
}

class _AvatarInitial extends StatelessWidget {
  final String displayName;

  const _AvatarInitial({required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Text(
      displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _OnlineIndicator extends StatelessWidget {
  const _OnlineIndicator();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: AppSpacings.xxl,
        height: AppSpacings.xxl,
        decoration: BoxDecoration(
          color: AppColors.success,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
    );
  }
}

// ── Info ──────────────────────────────────────────────────────────────────

class _ChatInfo extends StatelessWidget {
  final ChatModel chat;
  final UserModel otherUser;
  final String lastMessageTime;
  final String currentUserId;
  final int unreadCount;

  const _ChatInfo({
    required this.chat,
    required this.otherUser,
    required this.lastMessageTime,
    required this.currentUserId,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = chat.lastMessageSenderId == currentUserId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                otherUser.displayName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (lastMessageTime.isNotEmpty)
              Text(
                lastMessageTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: unreadCount > 0 ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
          ],
        ),
        Row(
          children: [
            if (isOwnMessage) ...[
              Icon(_getSeenStatusIcon(), size: AppSpacings.sm, color: _getSeenStatusColor()),
              const SizedBox(width: AppSpacings.xs),
            ],
            Expanded(
              child: Text(
                chat.lastMessage ?? context.loc.noMessagesYet,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: unreadCount > 0 ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        if (isOwnMessage) ...[
          const SizedBox(height: AppSpacings.xxs),
          Text(
            _getSeenStatusText(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getSeenStatusColor(),
                  fontSize: 11,
                ),
          ),
        ],
      ],
    );
  }

  IconData _getSeenStatusIcon() {
    final otherUserId = chat.getOtherParticipant(currentUserId);
    return chat.isMessageSeen(currentUserId, otherUserId) ? Icons.done_all : Icons.done;
  }

  Color _getSeenStatusColor() {
    final otherUserId = chat.getOtherParticipant(currentUserId);
    return chat.isMessageSeen(currentUserId, otherUserId) ? AppColors.primary : AppColors.textSecondary;
  }

  String _getSeenStatusText() {
    final otherUserId = chat.getOtherParticipant(currentUserId);
    return chat.isMessageSeen(currentUserId, otherUserId) ? context.loc.seen : context.loc.delivered;
  }
}

// ── Unread Badge ──────────────────────────────────────────────────────────

class _UnreadBadge extends StatelessWidget {
  final int unreadCount;

  const _UnreadBadge({required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppSpacings.sm),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.sm, vertical: AppSpacings.xxs),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        unreadCount > 99 ? '99+' : unreadCount.toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

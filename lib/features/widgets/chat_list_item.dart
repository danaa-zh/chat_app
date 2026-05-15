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
    final deleteChatLabel = context.loc.deleteChat;
    final deleteChatSubtitleLabel = context.loc.deleteChatSubtitle;
    final viewProfileLabel = context.loc.viewProfile;

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
              title: Text(deleteChatLabel),
              subtitle: Text(deleteChatSubtitleLabel),
              onTap: () {
                Get.back();
                homeController.deleteChat(chat);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: AppColors.primary),
              title: Text(viewProfileLabel),
              onTap: () {
                Get.back();
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
          radius: AppRadius.blockLg,
          backgroundColor: AppColors.primary,
          child: user.photoURL.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.blockLg),
                  child: Image.network(
                    user.photoURL,
                    width: AppRadius.blockLg * 2,
                    height: AppRadius.blockLg * 2,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _AvatarInitial(displayName: user.displayName),
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
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

// ── Info ──────────────────────────────────────────────────────────────────

class _ChatInfo extends StatefulWidget {
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
  State<_ChatInfo> createState() => _ChatInfoState();
}

class _ChatInfoState extends State<_ChatInfo> {
  @override
  Widget build(BuildContext context) {
    final isOwnMessage =
        widget.chat.lastMessageSenderId == widget.currentUserId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.otherUser.displayName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: widget.unreadCount > 0
                      ? FontWeight.bold
                      : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.lastMessageTime.isNotEmpty)
              Text(
                widget.lastMessageTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.unreadCount > 0
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: widget.unreadCount > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacings.xs),
        Row(
          children: [
            if (isOwnMessage) ...[
              Icon(
                _getSeenStatusIcon(),
                size: AppSpacings.sm,
                color: _getSeenStatusColor(),
              ),
              const SizedBox(width: AppSpacings.xs),
            ],
            Expanded(
              child: Text(
                widget.chat.lastMessage ?? context.loc.noMessagesYet,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.unreadCount > 0
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: widget.unreadCount > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
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
            _getSeenStatusText(context),
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
    final otherUserId = widget.chat.getOtherParticipant(widget.currentUserId);
    return widget.chat.isMessageSeen(widget.currentUserId, otherUserId)
        ? Icons.done_all
        : Icons.done;
  }

  Color _getSeenStatusColor() {
    final otherUserId = widget.chat.getOtherParticipant(widget.currentUserId);
    return widget.chat.isMessageSeen(widget.currentUserId, otherUserId)
        ? AppColors.primary
        : AppColors.textSecondary;
  }

  String _getSeenStatusText(BuildContext context) {
    final otherUserId = widget.chat.getOtherParticipant(widget.currentUserId);
    return widget.chat.isMessageSeen(widget.currentUserId, otherUserId)
        ? context.loc.seen
        : context.loc.delivered;
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.sm,
        vertical: AppSpacings.xxs,
      ),
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
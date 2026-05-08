import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

enum _FriendAction { message, remove, block }

class FriendListItem extends StatelessWidget {
  final UserModel friend;
  final String lastSeenText;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final VoidCallback onBlock;

  const FriendListItem({
    super.key,
    required this.friend,
    required this.lastSeenText,
    required this.onTap,
    required this.onRemove,
    required this.onBlock,
  });

  void _handleAction(_FriendAction action) {
    switch (action) {
      case _FriendAction.message:
        onTap();
      case _FriendAction.remove:
        onRemove();
      case _FriendAction.block:
        onBlock();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Row(
            children: [
              _FriendAvatar(friend: friend),
              const SizedBox(width: AppSpacings.lg),
              Expanded(
                child: _FriendInfo(
                  friend: friend,
                  lastSeenText: lastSeenText,
                ),
              ),
              _FriendMenu(onSelected: _handleAction),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Avatar ─────────────────────────────────────────────────────────────────

class _FriendAvatar extends StatelessWidget {
  final UserModel friend;

  const _FriendAvatar({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: AppRadius.blockLg,
          backgroundColor: AppColors.primary,
          child: friend.photoURL.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.blockLg),
                  child: Image.network(
                    friend.photoURL,
                    width: AppRadius.blockLg * 2,
                    height: AppRadius.blockLg * 2,
                    fit: BoxFit.cover,
                  ),
                )
              : _AvatarInitial(displayName: friend.displayName),
        ),
        if (friend.isOnline) const _OnlineIndicator(),
      ],
    );
  }
}

// ── Avatar Initial ─────────────────────────────────────────────────────────

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

// ── Online Indicator ───────────────────────────────────────────────────────

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

// ── Friend Info ────────────────────────────────────────────────────────────

class _FriendInfo extends StatelessWidget {
  final UserModel friend;
  final String lastSeenText;

  const _FriendInfo({
    required this.friend,
    required this.lastSeenText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          friend.displayName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          friend.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          lastSeenText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: friend.isOnline
                    ? AppColors.success
                    : AppColors.textSecondary,
                fontWeight: friend.isOnline
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}

// ── Popup Menu ─────────────────────────────────────────────────────────────

class _FriendMenu extends StatelessWidget {
  final ValueChanged<_FriendAction> onSelected;

  const _FriendMenu({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_FriendAction>(
      onSelected: onSelected,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => [
        _menuItem(
          value: _FriendAction.message,
          icon: Icons.chat_bubble_outline,
          label: context.loc.message,
        ),
        _menuItem(
          value: _FriendAction.remove,
          icon: Icons.person_remove_outlined,
          label: context.loc.removeFriend,
          color: AppColors.error,
        ),
        _menuItem(
          value: _FriendAction.block,
          icon: Icons.block,
          label: context.loc.blockUser,
          color: AppColors.error,
        ),
      ],
    );
  }

  PopupMenuItem<_FriendAction> _menuItem({
    required _FriendAction value,
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return PopupMenuItem(
      value: value,
      child: ListTile(
        leading: Icon(icon, color: color),
        contentPadding: EdgeInsets.zero,
        title: Text(label, style: color != null ? TextStyle(color: color) : null),
      ),
    );
  }
}
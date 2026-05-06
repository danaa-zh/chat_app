import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final UsersListController controller;

  const UserListItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = controller.getUserRelationshipStatus(user.id);
      if (status == UserRelationshipStatus.friends) return const SizedBox.shrink();

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Row(
            children: [
              _UserAvatar(displayName: user.displayName),
              const SizedBox(width: AppSpacings.lg),
              Expanded(
                child: _UserInfo(user: user),
              ),
              _RelationshipActions(
                user: user,
                status: status,
                controller: controller,
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ── Avatar ─────────────────────────────────────────────────────────────────

class _UserAvatar extends StatelessWidget {
  final String displayName;

  const _UserAvatar({required this.displayName});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppRadius.blockLg,
      backgroundColor: AppColors.primary,
      child: Text(
        displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ── User Info ──────────────────────────────────────────────────────────────

class _UserInfo extends StatelessWidget {
  final UserModel user;

  const _UserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.displayName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ── Relationship Actions ───────────────────────────────────────────────────

class _RelationshipActions extends StatelessWidget {
  final UserModel user;
  final UserRelationshipStatus status;
  final UsersListController controller;

  const _RelationshipActions({
    required this.user,
    required this.status,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPrimaryButton(context),
        if (status == UserRelationshipStatus.friendRequestReceived) ...[
          const SizedBox(height: AppSpacings.xs),
          _DeclineButton(user: user, controller: controller),
        ],
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    switch (status) {
      case UserRelationshipStatus.none:
      case UserRelationshipStatus.friendRequestReceived:
        return _PrimaryActionButton(
          user: user,
          status: status,
          controller: controller,
        );

      case UserRelationshipStatus.friendRequestSent:
        return _SentRequestButton(
          user: user,
          status: status,
          controller: controller,
        );

      case UserRelationshipStatus.friends:
      case UserRelationshipStatus.blocked:
        return const SizedBox.shrink();
    }
  }
}

// ── Primary Action Button ──────────────────────────────────────────────────

class _PrimaryActionButton extends StatelessWidget {
  final UserModel user;
  final UserRelationshipStatus status;
  final UsersListController controller;

  const _PrimaryActionButton({
    required this.user,
    required this.status,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => controller.handleRelationshipButtonPress(user),
      icon: Icon(controller.getRelationshipButtonIcon(status), size: AppSpacings.xl),
      label: Text(controller.getRelationshipButtonText(status)),
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.getRelationshipButtonColor(status),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: AppPaddings.sm,
          horizontal: AppPaddings.md,
        ),
        minimumSize: const Size(0, AppSpacings.screen),
      ),
    );
  }
}

// ── Sent Request Button ────────────────────────────────────────────────────

class _SentRequestButton extends StatelessWidget {
  final UserModel user;
  final UserRelationshipStatus status;
  final UsersListController controller;

  const _SentRequestButton({
    required this.user,
    required this.status,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final color = controller.getRelationshipButtonColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddings.sm,
            horizontal: AppPaddings.md,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                controller.getRelationshipButtonIcon(status),
                color: color,
                size: AppSpacings.xl,
              ),
              const SizedBox(width: AppSpacings.xs),
              Text(
                controller.getRelationshipButtonText(status),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacings.xs),
        _CancelRequestButton(user: user, controller: controller),
      ],
    );
  }
}

// ── Cancel Request Button ──────────────────────────────────────────────────

class _CancelRequestButton extends StatelessWidget {
  final UserModel user;
  final UsersListController controller;

  const _CancelRequestButton({
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showCancelDialog(context),
      icon: const Icon(Icons.cancel_outlined, size: AppSpacings.xl),
      label: Text(context.loc.cancel),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: AppPaddings.xs,
          horizontal: AppPaddings.sm,
        ),
        minimumSize: const Size(0, AppSpacings.blockLg),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(context.loc.cancelFriendRequestTitle),
        content: Text(
          context.loc.cancelFriendRequestMessage(user.displayName),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(context.loc.keepRequest),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelFriendRequest(user);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(context.loc.cancelRequest),
          ),
        ],
      ),
    );
  }
}

// ── Decline Button ─────────────────────────────────────────────────────────

class _DeclineButton extends StatelessWidget {
  final UserModel user;
  final UsersListController controller;

  const _DeclineButton({
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => controller.declineFriendRequest(user),
      icon: const Icon(Icons.close, size: AppSpacings.xl),
      label: Text(context.loc.decline),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.error,
        padding: const EdgeInsets.symmetric(
          vertical: AppPaddings.xs,
          horizontal: AppPaddings.sm,
        ),
        minimumSize: const Size(0, AppSpacings.blockLg),
      ),
    );
  }
}
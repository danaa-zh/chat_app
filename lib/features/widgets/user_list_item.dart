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
      if (status == UserRelationshipStatus.friends)
        return const SizedBox.shrink();

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Row(
            children: [
              _UserAvatar(displayName: user.displayName),
              const SizedBox(width: AppSpacings.lg),
              Expanded(child: _UserInfo(user: user)),
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
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          user.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
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
    return Row(
      // 👈 was Column
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPrimaryButton(context),
        if (status == UserRelationshipStatus.friendRequestReceived) ...[
          const SizedBox(width: AppSpacings.xs), // 👈 was height
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
    if (status == UserRelationshipStatus.friendRequestReceived) {
      return _AcceptIconButton(user: user, controller: controller);
    }

    return ElevatedButton.icon(
      onPressed: () => controller.handleRelationshipButtonPress(user),
      icon: Icon(
        controller.getRelationshipButtonIcon(status),
        size: AppSpacings.lg,
      ),
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

// ── Accept Icon Button (✓) ─────────────────────────────────────────────────

class _AcceptIconButton extends StatelessWidget {
  final UserModel user;
  final UsersListController controller;

  const _AcceptIconButton({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacings.screenLg,
      height: AppSpacings.screenLg,
      decoration: BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
          size: AppSpacings.lg,
        ),
        onPressed: () => controller.handleRelationshipButtonPress(user),
      ),
    );
  }
}

// ── Decline Button (✕) ────────────────────────────────────────────────────

class _DeclineButton extends StatelessWidget {
  final UserModel user;
  final UsersListController controller;

  const _DeclineButton({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacings.screenLg,
      height: AppSpacings.screenLg,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.error),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.close, color: AppColors.error, size: AppSpacings.lg),
        onPressed: () => controller.declineFriendRequest(user),
      ),
    );
  }
}

// ── Sent Request (Pending + Cancel) ───────────────────────────────────────

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.sm,
            vertical: AppPaddings.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time_rounded,
                size: AppSpacings.lg,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacings.xs),
              Text(
                context.loc.pending,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacings.xs),
        _CancelRequestButton(user: user, controller: controller),
      ],
    );
  }
}

// ── Cancel Request Button (✕ small) ───────────────────────────────────────

class _CancelRequestButton extends StatelessWidget {
  final UserModel user;
  final UsersListController controller;

  const _CancelRequestButton({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCancelDialog(context),
      child: Container(
        width: AppSpacings.screenLg,
        height: AppSpacings.screenLg,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close, size: AppSpacings.lg, color: AppColors.error),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(context.loc.cancelFriendRequestTitle),
        content: Text(context.loc.cancelFriendRequestMessage(user.displayName)),
        actions: [
          TextButton(onPressed: Get.back, child: Text(context.loc.keepRequest)),
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

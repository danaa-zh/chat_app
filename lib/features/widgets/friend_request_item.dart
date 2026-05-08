import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/friend_request_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

class FriendRequestItem extends StatelessWidget {
  final FriendRequestModel request;
  final UserModel user;
  final String timeText;
  final bool isReceived;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String? statusText;
  final Color? statusColor;

  const FriendRequestItem({
    super.key,
    required this.request,
    required this.user,
    required this.timeText,
    required this.isReceived,
    this.onAccept,
    this.onDecline,
    this.statusText,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.block),
        child: Column(
          children: [
            Row(
              children: [
                _RequestAvatar(user: user),
                const SizedBox(width: AppSpacings.md),
                Expanded(child: _RequestInfo(user: user, timeText: timeText)),
              ],
            ),
            if (isReceived && request.status == FriendRequestStatus.pending)
              const SizedBox(height: AppSpacings.lg),
            if (isReceived && request.status == FriendRequestStatus.pending)
              _RequestActions(onAccept: onAccept, onDecline: onDecline),
            if (!isReceived && statusText != null)
              const SizedBox(height: AppSpacings.md),
            if (!isReceived && statusText != null)
              _RequestStatus(statusText: statusText!, statusColor: statusColor, status: request.status),
          ],
        ),
      ),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────

class _RequestAvatar extends StatelessWidget {
  final UserModel user;

  const _RequestAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSpacings.block,
      backgroundColor: AppColors.primary,
      child: user.photoURL.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacings.block),
              child: Image.network(
                user.photoURL,
                width: AppConstants.networkImageSize,
                height: AppConstants.networkImageSize,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _AvatarInitial(displayName: user.displayName),
              ),
            )
          : _AvatarInitial(displayName: user.displayName),
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

// ── Info ──────────────────────────────────────────────────────────────────

class _RequestInfo extends StatelessWidget {
  final UserModel user;
  final String timeText;

  const _RequestInfo({required this.user, required this.timeText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                user.displayName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              timeText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}

// ── Actions ───────────────────────────────────────────────────────────────

class _RequestActions extends StatelessWidget {
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const _RequestActions({this.onAccept, this.onDecline});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onDecline,
            icon: const Icon(Icons.close),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.error),
              foregroundColor: AppColors.error,
            ),
            label: Text(context.loc.decline),
          ),
        ),
        const SizedBox(width: AppSpacings.md),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAccept,
            icon: const Icon(Icons.check),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
            ),
            label: Text(context.loc.accept),
          ),
        ),
      ],
    );
  }
}

// ── Status ────────────────────────────────────────────────────────────────

class _RequestStatus extends StatelessWidget {
  final String statusText;
  final Color? statusColor;
  final FriendRequestStatus status;

  const _RequestStatus({
    required this.statusText,
    required this.statusColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.xs, horizontal: AppSpacings.sm),
      decoration: BoxDecoration(
        color: statusColor?.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.fifty),
        border: Border.all(color: statusColor ?? AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: AppSpacings.xxl, color: statusColor),
          const SizedBox(width: AppSpacings.xs),
          Text(
            statusText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: statusColor ?? AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (status) {
      case FriendRequestStatus.accepted:
        return Icons.check_circle;
      case FriendRequestStatus.rejected:
        return Icons.cancel;
      case FriendRequestStatus.pending:
      default:
        return Icons.hourglass_top;
    }
  }
}

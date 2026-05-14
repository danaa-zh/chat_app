import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/notification_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

class NotificationInfo extends StatelessWidget {
  final NotificationModel notification;
  final UserModel? user;
  final String timeText;

  const NotificationInfo({
    super.key,
    required this.notification,
    this.user,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                    ),
              ),
            ),
            if (!notification.isRead)
              Container(
                width: AppSpacings.xs,
                height: AppSpacings.xs,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacings.xxs),
        Text(
          _getNotificationBody(context),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacings.xxs),
        Text(timeText, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  String _getNotificationBody(dynamic context) {
    if (user == null) return notification.body;

    switch (notification.type) {
      case NotificationType.friendRequest:
        return context.loc.friendRequestBody(user!.displayName);
      case NotificationType.friendRequestAccepted:
        return context.loc.friendRequestAcceptedBody(user!.displayName);
      case NotificationType.friendRequestRejected:
        return context.loc.friendRequestRejectedBody(user!.displayName);
      case NotificationType.newMessage:
        return context.loc.newMessageBody(user!.displayName);
      case NotificationType.friendRemoved:
        return context.loc.friendRemovedBody(user!.displayName);
    }
  }
}

import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/notification_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/features/notifications/widgets/notification_delete_button.dart';
import 'package:chat_app/features/notifications/widgets/notification_icon.dart';
import 'package:chat_app/features/notifications/widgets/notification_info.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final UserModel? user;
  final String timeText;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    this.user,
    required this.timeText,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: notification.isRead ? null : AppColors.primary.withValues(alpha: 0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Row(
            children: [
              NotificationIcon(icon: icon, iconColor: iconColor),
              const SizedBox(width: AppSpacings.lg),
              Expanded(
                child: NotificationInfo(
                  notification: notification,
                  user: user,
                  timeText: timeText,
                ),
              ),
              NotificationDeleteButton(onDelete: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}

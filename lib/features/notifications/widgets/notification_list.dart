import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/controllers/notification_controller.dart';
import 'package:chat_app/features/notifications/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return ListView.separated(
      padding: const EdgeInsets.all(AppPaddings.block),
      itemCount: controller.notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacings.sm),
      itemBuilder: (_, index) {
        final notification = controller.notifications[index];
        final user = notification.data['senderId'] != null
            ? controller.getUser(notification.data['senderId'])
            : notification.data['userId'] != null
                ? controller.getUser(notification.data['userId'])
                : null;

        return NotificationItem(
          notification: notification,
          user: user,
          timeText: controller.getNotificationTimeText(notification.createdAt),
          icon: controller.getNotificationIcon(notification.type),
          iconColor: controller.getNotificationIconColor(notification.type),
          onTap: () => controller.handleNotificationTap(notification),
          onDelete: () => controller.deleteNotification(notification),
        );
      },
    );
  }
}

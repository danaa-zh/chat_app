import 'package:chat_app/core/controllers/notification_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final NotificationController controller;

  const NotificationAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(context.loc.notifications),
      leading: IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        Obx(() {
          final unreadCount = controller.getUnreadCount();
          return unreadCount > 0
              ? TextButton(
                  onPressed: controller.markAllAsRead,
                  child: Text(context.loc.markAllRead),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

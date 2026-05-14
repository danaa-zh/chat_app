import 'package:chat_app/core/controllers/notification_controller.dart';
import 'package:chat_app/features/notifications/widgets/notification_app_bar.dart';
import 'package:chat_app/features/notifications/widgets/notification_empty_state.dart';
import 'package:chat_app/features/notifications/widgets/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationAppBar(controller: controller),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const NotificationEmptyState();
        }
        return const NotificationList();
      }),
    );
  }
}

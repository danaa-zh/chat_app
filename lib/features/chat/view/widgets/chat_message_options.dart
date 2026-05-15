import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/controllers/chat_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessageOptions {
  static void show(BuildContext context, ChatController controller, dynamic message) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppPaddings.blockLg),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.hero)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: AppColors.primary),
              title: Text(context.loc.editMessage),
              onTap: () {
                Get.back();
                _showEditDialog(context, controller, message);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: AppColors.error),
              title: Text(context.loc.deleteMessage),
              onTap: () {
                Get.back();
                _showDeleteDialog(context, controller, message);
              },
            ),
          ],
        ),
      ),
    );
  }

  static void _showEditDialog(BuildContext context, ChatController controller, dynamic message) {
    final editController = TextEditingController(text: message.content);

    Get.dialog(
      AlertDialog(
        title: Text(context.loc.editMessage),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: context.loc.enterNewMessage),
          maxLines: null,
        ),
        actions: [
          TextButton(onPressed: Get.back, child: Text(context.loc.cancel)),
          TextButton(
            onPressed: () {
              if (editController.text.trim().isNotEmpty) {
                controller.editMessage(message, editController.text.trim());
                Get.back();
              }
            },
            child: Text(context.loc.save),
          ),
        ],
      ),
    );
  }

  static void _showDeleteDialog(BuildContext context, ChatController controller, dynamic message) {
    Get.dialog(
      AlertDialog(
        title: Text(context.loc.deleteMessage),
        content: Text(context.loc.deleteMessageConfirm),
        actions: [
          TextButton(onPressed: Get.back, child: Text(context.loc.cancel)),
          TextButton(
            onPressed: () {
              controller.deleteMessage(message);
              Get.back();
            },
            child: Text(context.loc.delete),
          ),
        ],
      ),
    );
  }
}
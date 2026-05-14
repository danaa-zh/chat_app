import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/friend_requests/widgets/requests_empty_state.dart';
import 'package:chat_app/features/widgets/friend_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsSentTab extends StatelessWidget {
  final FriendRequestsController controller;

  const RequestsSentTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.sentRequests.isEmpty) {
        return RequestsEmptyState(
          icon: Icons.send_outlined,
          title: context.loc.noSentRequests,
          message: context.loc.noSentRequestsMessage,
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(AppPaddings.block),
        itemCount: controller.sentRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacings.sm),
        itemBuilder: (_, index) {
          final request = controller.sentRequests[index];
          final receiver = controller.getUser(request.receiverId);
          if (receiver == null) return const SizedBox.shrink();

          return FriendRequestItem(
            request: request,
            user: receiver,
            timeText: controller.getRequestTimeText(request.createdAt),
            isReceived: false,
            statusText: controller.getStatusText(request.status),
            statusColor: controller.getStatusColor(request.status),
          );
        },
      );
    });
  }
}

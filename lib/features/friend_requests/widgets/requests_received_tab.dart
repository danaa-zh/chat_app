import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/friend_requests/widgets/requests_empty_state.dart';
import 'package:chat_app/features/widgets/friend_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsReceivedTab extends StatelessWidget {
  final FriendRequestsController controller;

  const RequestsReceivedTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.receivedRequests.isEmpty) {
        return RequestsEmptyState(
          icon: Icons.inbox_outlined,
          title: context.loc.noFriendRequests,
          message: context.loc.noFriendRequestsMessage,
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(AppPaddings.block),
        itemCount: controller.receivedRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacings.sm),
        itemBuilder: (_, index) {
          final request = controller.receivedRequests[index];
          final sender = controller.getUser(request.senderId);
          if (sender == null) return const SizedBox.shrink();

          return FriendRequestItem(
            request: request,
            user: sender,
            timeText: controller.getRequestTimeText(request.createdAt),
            isReceived: true,
            onAccept: () => controller.acceptRequest(request),
            onDecline: () => controller.declineFriendRequest(request),
          );
        },
      );
    });
  }
}

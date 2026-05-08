import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/widgets/friend_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestsView extends GetView<FriendRequestsController> {
  const FriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.friendRequests),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
        ),
      ),
      body: Column(
        children: [
          _RequestsTabBar(controller: controller),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedTabIndex,
                children: [
                  _ReceivedRequestsTab(controller: controller),
                  _SentRequestsTab(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab Bar ────────────────────────────────────────────────────────────────

class _RequestsTabBar extends StatelessWidget {
  final FriendRequestsController controller;

  const _RequestsTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPaddings.block),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Obx(
        () => Row(
          children: [
            _TabButton(
              icon: Icons.inbox,
              label: context.loc.receivedRequests(controller.receivedRequests.length),
              isSelected: controller.selectedTabIndex == 0,
              onTap: () => controller.changeTab(0),
            ),
            _TabButton(
              icon: Icons.send,
              label: context.loc.sentRequests(controller.sentRequests.length),
              isSelected: controller.selectedTabIndex == 1,
              onTap: () => controller.changeTab(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacings.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: AppSpacings.sm),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Received Requests Tab ──────────────────────────────────────────────────

class _ReceivedRequestsTab extends StatelessWidget {
  final FriendRequestsController controller;

  const _ReceivedRequestsTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.receivedRequests.isEmpty) {
        return _EmptyState(
          icon: Icons.inbox_outlined,
          title: context.loc.noFriendRequests,
          message: context.loc.noFriendRequestsMessage,
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(AppPaddings.block),
        itemCount: controller.receivedRequests.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.sm),
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

// ── Sent Requests Tab ─────────────────────────────────────────────────────

class _SentRequestsTab extends StatelessWidget {
  final FriendRequestsController controller;

  const _SentRequestsTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.sentRequests.isEmpty) {
        return _EmptyState(
          icon: Icons.send_outlined,
          title: context.loc.noSentRequests,
          message: context.loc.noSentRequestsMessage,
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(AppPaddings.block),
        itemCount: controller.sentRequests.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.sm),
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

// ── Empty State ───────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppConstants.emptyIconSize,
              height: AppConstants.emptyIconSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.fifty),
              ),
              child: Icon(icon, size: AppSpacings.hero, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacings.xl),
            Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacings.sm),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

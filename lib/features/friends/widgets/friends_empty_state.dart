import 'package:chat_app/core/controllers/friends_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FriendsEmptyState extends StatelessWidget {
  final FriendsController controller;

  const FriendsEmptyState({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final hasQuery = controller.searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.hero),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmptyStateIcon(),
            const SizedBox(height: AppSpacings.xxl),
            Text(
              hasQuery ? context.loc.noFriendsFound : context.loc.noFriendsYet,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.sm),
            Text(
              hasQuery ? context.loc.tryDifferentSearch : context.loc.addFriendsToChat,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (!hasQuery) ...[
              const SizedBox(height: AppSpacings.lg),
              _ViewRequestsButton(controller: controller),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyStateIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacings.large,
      height: AppSpacings.large,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.fifty),
      ),
      child: const Icon(Icons.people_outline, size: AppSpacings.fifty, color: AppColors.primary),
    );
  }
}

class _ViewRequestsButton extends StatelessWidget {
  final FriendsController controller;

  const _ViewRequestsButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: controller.openFriendRequests,
      icon: const Icon(Icons.person_search),
      label: Text(context.loc.viewFriendRequests),
    );
  }
}

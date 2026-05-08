import 'package:chat_app/core/controllers/friends_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/widgets/friends_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsView extends GetView<FriendsController> {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.friends),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.onInit,
          ),
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            onPressed: controller.openFriendRequests,
          ),
        ],
      ),
      body: Column(
        children: [
          _FriendsSearchBar(controller: controller),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshFriends,
              child: Obx(() {
                if (controller.isLoading && controller.friends.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredFriends.isEmpty) {
                  return _FriendsEmptyState(controller: controller);
                }
                return _FriendsList(controller: controller);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Search Bar ─────────────────────────────────────────────────────────────

class _FriendsSearchBar extends StatelessWidget {
  final FriendsController controller;

  const _FriendsSearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.block),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: InputDecoration(
          hintText: context.loc.searchFriends,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Obx(() => controller.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                )
              : const SizedBox.shrink()),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.card,
        ),
      ),
    );
  }
}

// ── Friends List ───────────────────────────────────────────────────────────

class _FriendsList extends StatelessWidget {
  final FriendsController controller;

  const _FriendsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppPaddings.block),
      itemCount: controller.filteredFriends.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.sm),
      itemBuilder: (_, index) {
        final friend = controller.filteredFriends[index];
        return FriendListItem(
          friend: friend,
          lastSeenText: controller.getLastSeenText(friend),
          onTap: () => controller.startChat(friend),
          onRemove: () => controller.removeFriend(friend),
          onBlock: () => controller.blockFriend(friend),
        );
      },
    );
  }
}

// ── Empty State ────────────────────────────────────────────────────────────

class _FriendsEmptyState extends StatelessWidget {
  final FriendsController controller;

  const _FriendsEmptyState({required this.controller});

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
              hasQuery
                  ? context.loc.noFriendsFound
                  : context.loc.noFriendsYet,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.sm),
            Text(
              hasQuery
                  ? context.loc.tryDifferentSearch
                  : context.loc.addFriendsToChat,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
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

// ── Empty State Icon ───────────────────────────────────────────────────────

class _EmptyStateIcon extends StatelessWidget {
  const _EmptyStateIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacings.large,
      height: AppSpacings.large,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.fifty),
      ),
      child: const Icon(
        Icons.people_outline,
        size: AppSpacings.fifty,
        color: AppColors.primary,
      ),
    );
  }
}

// ── View Requests Button ───────────────────────────────────────────────────

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
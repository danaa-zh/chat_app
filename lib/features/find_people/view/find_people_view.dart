import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/widgets/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPeopleView extends GetView<UsersListController> {
  const FindPeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.findFriends),
        leading: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          _SearchBar(controller: controller),
          Expanded(
            child: Obx(() => controller.filteredUsers.isEmpty
                ? _EmptyState(controller: controller)
                : _UserList(controller: controller)),
          ),
        ],
      ),
    );
  }
}

// ── User List ──────────────────────────────────────────────────────────────

class _UserList extends StatelessWidget {
  final UsersListController controller;

  const _UserList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppPaddings.block),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacings.sm),
      itemCount: controller.filteredUsers.length,
      itemBuilder: (_, index) {
        final user = controller.filteredUsers[index];
        return UserListItem(
          user: user,
          onTap: () => controller.handleRelationshipButtonPress(user),
          controller: controller,
        );
      },
    );
  }
}

// ── Search Bar ─────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final UsersListController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.block),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: InputDecoration(
          hintText: context.loc.searchPeople,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.block,
          ),
        ),
      ),
    );
  }
}

// ── Empty State ────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final UsersListController controller;

  const _EmptyState({required this.controller});

  @override
  Widget build(BuildContext context) {
    final hasQuery = controller.searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.hero),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: AppSpacings.fifty,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacings.lg),
            Text(
              hasQuery
                  ? context.loc.noResultsFound
                  : context.loc.noPeopleFound,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.sm),
            Text(
              hasQuery
                  ? context.loc.tryDifferentSearch
                  : context.loc.allUsersWillAppearHere,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
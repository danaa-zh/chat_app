import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PeopleEmptyState extends StatelessWidget {
  final UsersListController controller;

  const PeopleEmptyState({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final hasQuery = controller.searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.hero),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: AppSpacings.fifty, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacings.lg),
            Text(
              hasQuery ? context.loc.noResultsFound : context.loc.noPeopleFound,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacings.sm),
            Text(
              hasQuery ? context.loc.tryDifferentSearch : context.loc.allUsersWillAppearHere,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

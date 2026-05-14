import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/features/widgets/user_list_item.dart';
import 'package:flutter/material.dart';

class PeopleUserList extends StatelessWidget {
  final UsersListController controller;

  const PeopleUserList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppPaddings.block),
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacings.sm),
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

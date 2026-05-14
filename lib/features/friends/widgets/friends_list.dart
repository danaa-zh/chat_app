import 'package:chat_app/core/controllers/friends_controller.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/features/widgets/friends_list_item.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  final FriendsController controller;

  const FriendsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppPaddings.block),
      itemCount: controller.filteredFriends.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacings.sm),
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

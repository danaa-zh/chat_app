import 'package:chat_app/core/controllers/friends_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/friends/widgets/friends_empty_state.dart';
import 'package:chat_app/features/friends/widgets/friends_list.dart';
import 'package:chat_app/features/friends/widgets/friends_search_bar.dart';
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
          IconButton(icon: const Icon(Icons.refresh), onPressed: controller.onInit),
          IconButton(icon: const Icon(Icons.person_add_alt_1), onPressed: controller.openFriendRequests),
        ],
      ),
      body: Column(
        children: [
          FriendsSearchBar(controller: controller),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshFriends,
              child: Obx(() {
                if (controller.isLoading && controller.friends.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredFriends.isEmpty) {
                  return FriendsEmptyState(controller: controller);
                }
                return FriendsList(controller: controller);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

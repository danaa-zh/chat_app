import 'package:chat_app/core/controllers/users_list_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/find_people/widgets/people_empty_state.dart';
import 'package:chat_app/features/find_people/widgets/people_search_bar.dart';
import 'package:chat_app/features/find_people/widgets/people_user_list.dart';
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
          PeopleSearchBar(controller: controller),
          Expanded(
            child: Obx(() => controller.filteredUsers.isEmpty
                ? PeopleEmptyState(controller: controller)
                : PeopleUserList(controller: controller)),
          ),
        ],
      ),
    );
  }
}

import 'package:chat_app/core/controllers/friend_requests_controller.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/features/friend_requests/widgets/requests_received_tab.dart';
import 'package:chat_app/features/friend_requests/widgets/requests_sent_tab.dart';
import 'package:chat_app/features/friend_requests/widgets/requests_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestsView extends GetView<FriendRequestsController> {
  const FriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.friendRequests),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: Get.back),
      ),
      body: Column(
        children: [
          RequestsTabBar(controller: controller),
          Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.selectedTabIndex,
                  children: [
                    RequestsReceivedTab(controller: controller),
                    RequestsSentTab(controller: controller),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

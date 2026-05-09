import 'package:chat_app/core/controllers/auth_controller.dart';
import 'package:chat_app/core/controllers/home_controller.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/home/widgets/home_app_bar.dart';
import 'package:chat_app/features/home/widgets/home_search_bar.dart';
import 'package:chat_app/features/home/widgets/home_filters.dart';
import 'package:chat_app/features/home/widgets/home_search_results.dart';
import 'package:chat_app/features/home/widgets/home_chats_list.dart';
import 'package:chat_app/features/home/widgets/home_empty_states.dart';
import 'package:chat_app/features/home/widgets/home_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: HomeAppBar(controller: controller, authController: authController),
      body: Column(
        children: [
          const HomeSearchBar(),
          Obx(() {
            if (controller.isSearching && controller.searchQuery.isNotEmpty) {
              return const HomeSearchResults();
            }
            return const HomeFilters();
          }),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshChats,
              color: AppColors.primary,
              child: Obx(() {
                if (controller.chats.isEmpty) {
                  if (controller.isSearching && controller.searchQuery.isNotEmpty) {
                    return const HomeNoSearchResults();
                  } else if (controller.activeFilter != 'All') {
                    return const HomeNoFilterResults();
                  } else {
                    return const HomeEmptyState();
                  }
                }
                return const HomeChatsList();
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: const HomeFab(),
    );
  }
}

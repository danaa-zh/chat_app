import 'package:chat_app/core/controllers/main_controller.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/features/widgets/app_nav_bar.dart';
import 'package:chat_app/data/models/nav_item_model.dart';
import 'package:chat_app/features/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppShell extends GetView<MainController> {
  const AppShell({super.key});

  List<NavItemModel> _navItems(BuildContext context, int unreadCount) => [
    NavItemModel(
      icon: Icons.chat_outlined,
      activeIcon: Icons.chat,
      label: context.loc.chats,
      badgeCount: unreadCount,
    ),
    NavItemModel(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: context.loc.friends,
    ),
    NavItemModel(
      icon: Icons.person_search_outlined,
      activeIcon: Icons.person_search,
      label: context.loc.findFriends,
    ),
    NavItemModel(
      icon: Icons.account_circle_outlined,
      activeIcon: Icons.account_circle,
      label: context.loc.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: const [
          // HomeView(),
          // FriendsView(),
          // UsersListView(),
          Center(child: Text('Chats')),
          Center(child: Text('Friends')),
          Center(child: Text('Find Friends')),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AppNavBar(
          currentIndex: controller.currentIndex,
          onTap: controller.changeTabIndex,
          items: _navItems(context, controller.getUnreadCount()),
        ),
      ),
    );
  }
}
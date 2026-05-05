import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/data/models/nav_item_model.dart';
import 'package:chat_app/features/widgets/nav_badge_icon.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItemModel> items;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: Colors.white,
      elevation: 8,
      items: items.map(_buildItem).toList(),
    );
  }

  BottomNavigationBarItem _buildItem(NavItemModel item) {
    return BottomNavigationBarItem(
      icon: item.badgeCount > 0
          ? NavBadgeIcon(icon: item.icon, count: item.badgeCount)
          : Icon(item.icon),
      activeIcon: item.badgeCount > 0
          ? NavBadgeIcon(icon: item.activeIcon, count: item.badgeCount)
          : Icon(item.activeIcon),
      label: item.label,
    );
  }
}
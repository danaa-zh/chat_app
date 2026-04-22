import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../widgets/app_svg.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  int _currentIndex(String location) {
    if (location.startsWith(RouteNames.friends)) {
      return AppConstants.friendsTabIndex;
    }
    if (location.startsWith(RouteNames.findFriends)) {
      return AppConstants.findFriendsTabIndex;
    }
    if (location.startsWith(RouteNames.profile)) {
      return AppConstants.profileTabIndex;
    }
    return AppConstants.chatsTabIndex;
  }

  void _onTabTapped(BuildContext context, int index) {
    final router = GoRouter.of(context);
    switch (index) {
      case AppConstants.chatsTabIndex:
        router.go(RouteNames.chats);
        break;
      case AppConstants.friendsTabIndex:
        router.go(RouteNames.friends);
        break;
      case AppConstants.findFriendsTabIndex:
        router.go(RouteNames.findFriends);
        break;
      case AppConstants.profileTabIndex:
        router.go(RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _currentIndex(location);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? AppColors.darkNavActive : AppColors.navActive;
    final inactiveColor =
        isDark ? AppColors.darkNavInactive : AppColors.navInactive;
    final bgColor = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkDivider : AppColors.divider;
    final tabs = <_ShellTabItem>[
      _ShellTabItem(
        index: AppConstants.chatsTabIndex,
        label: loc.tabChats,
        iconPath: AssetPaths.chatsIcon,
      ),
      _ShellTabItem(
        index: AppConstants.friendsTabIndex,
        label: loc.tabFriends,
        iconPath: AssetPaths.friendsIcon,
      ),
      _ShellTabItem(
        index: AppConstants.findFriendsTabIndex,
        label: loc.tabFindFriends,
        iconPath: AssetPaths.findFriendsIcon,
      ),
      _ShellTabItem(
        index: AppConstants.profileTabIndex,
        label: loc.tabProfile,
        iconPath: AssetPaths.profileIcon,
      ),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        height: AppConstants.bottomNavHeight,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: AppConstants.defaultBorderWidth,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: tabs
              .map(
                (tab) => Expanded(
                  child: _ShellNavItem(
                    item: tab,
                    isSelected: selectedIndex == tab.index,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => _onTabTapped(context, tab.index),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}

class _ShellTabItem {
  final int index;
  final String label;
  final String iconPath;

  const _ShellTabItem({
    required this.index,
    required this.label,
    required this.iconPath,
  });
}

class _ShellNavItem extends StatelessWidget {
  final _ShellTabItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _ShellNavItem({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? activeColor : inactiveColor;
    final labelStyle = AppTextStyles.navLabel.copyWith(
      color: iconColor,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
    );

    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvg(
              assetPath: item.iconPath,
              size: AppConstants.iconMd,
              color: iconColor,
            ),
            const SizedBox(height: AppSpacings.xxs),
            Text(
              item.label,
              style: labelStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NavItemModel {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int badgeCount;

  const NavItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badgeCount = 0,
  });
}
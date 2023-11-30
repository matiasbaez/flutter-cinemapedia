
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:cinemapedia/config/records/records.dart';

class NavigationItem {

  final String url;
  final Widget icon;
  final String? label;
  final Widget? activeIcon;
  final Color? backgroundColor;
  final String? tooltip;

  const NavigationItem({
    required this.url,
    required this.icon,
    this.label,
    this.activeIcon,
    this.backgroundColor,
    this.tooltip
  });
}

const List<NavigationItem> navigationItems = [
  NavigationItem(url: '/', icon: Icon(Icons.home_max), label: 'Home'),
  NavigationItem(url: '/categories', icon: Icon(Icons.label_outline), label: 'Categories'),
  NavigationItem(url: '/favorites', icon: Icon(Icons.label_outline), label: 'Favorites'),
];

class CustomNavigationBar extends StatelessWidget {

  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: RouterManager.getCurrentRouteWithIdx(ctx: context).$1,
      onTap: (index) => context.go(RouterManager.getCurrentRouteWithIdx(idx: index).$2),
      items: [

        ...navigationItems.map((item) => BottomNavigationBarItem(
          icon: item.icon,
          activeIcon: Icon(Icons.home_max, color: colors.primary),
          label: item.label ?? ''
        )),

      ]
    );
  }
}

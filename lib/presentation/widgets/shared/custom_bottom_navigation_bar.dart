
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {

  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      elevation: 0,
      items: [

        BottomNavigationBarItem(
          icon: Icon(Icons.home_max, color: colors.secondary),
          activeIcon: Icon(Icons.home_max, color: colors.primary),
          label: "Home"
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline, color: colors.secondary),
          activeIcon: Icon(Icons.label_outline, color: colors.primary),
          label: "Categories"
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline, color: colors.secondary),
          activeIcon: Icon(Icons.favorite_outline, color: colors.primary),
          label: "Favorites"
        ),

      ],
    );
  }
}
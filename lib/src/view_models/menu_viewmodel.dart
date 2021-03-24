import 'package:flutter/material.dart';

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;

  const Menu({
    this.title,
    this.icon,
    this.iconColor = Colors.grey,
    this.onTap,
  });
}

class MenuViewModel {
  MenuViewModel();

  List<Menu> get items => <Menu>[
    Menu(
      title: 'Profile',
      icon: Icons.person,
      iconColor: Color(0XFF93291E),
      onTap: (context) {
        //todo
      },
    ),
    Menu(
      title: 'Dashboard',
      icon: Icons.dashboard,
      iconColor: Color(0XFF93291E),
      onTap: (context) {
        //todo
      },
    ),
    Menu(
      title: 'Maps',
      icon: Icons.map,
      iconColor: Color(0XFF93291E),
      onTap: (context) {
        //todo
      },
    ),
    Menu(
      title: 'Timeline',
      icon: Icons.timeline,
      iconColor: Color(0XFF93291E),
      onTap: (context) {
        //todo
      },
    ),
    Menu(
      title: 'Settings',
      icon: Icons.settings,
      iconColor: Color(0XFF93291E),
      onTap: (context) {
        //todo
      },
    ),
  ];
}
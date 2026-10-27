import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomnavbarViewModel extends BaseViewModel {
  final List<BottomNavItemData> items = const [
    BottomNavItemData(
      label: 'Home',
      icon: Icons.home_rounded,
      title: 'Dashboard',
      subtitle: 'Overview of your balance, quick actions, and recent activity.',
    ),
    BottomNavItemData(
      label: 'Rates',
      icon: Icons.bar_chart_rounded,
      title: 'Rates',
      subtitle: 'Track live crypto rates and quick market pricing updates.',
    ),
    BottomNavItemData(
      label: 'Trade',
      icon: Icons.swap_horiz_rounded,
      title: 'Trade',
      subtitle: 'Monitor rates, swap pairs, and move into your next position.',
    ),
    BottomNavItemData(
      label: 'Cards',
      icon: Icons.style_rounded,
      title: 'Gift Cards',
      subtitle: 'Manage card deals, redemptions, and recent exchange activity.',
    ),
    BottomNavItemData(
      label: 'Profile',
      icon: Icons.person_rounded,
      title: 'Profile',
      subtitle: 'Control security, account settings, and verification details.',
    ),
  ];

  int currentIndex = 0;
  final Set<int> _visitedTabs = {0};

  bool hasVisitedTab(int index) => _visitedTabs.contains(index);

  void selectTab(int index) {
    if (index == currentIndex) return;
    _visitedTabs.add(index);
    currentIndex = index;
    rebuildUi();
  }

  BottomNavItemData get currentItem => items[currentIndex];
}

class BottomNavItemData {
  const BottomNavItemData({
    required this.label,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String label;
  final IconData icon;
  final String title;
  final String subtitle;
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:koinkard/common/app_assets.dart';

import 'models/popular_card.dart';

class HomeViewModel extends BaseViewModel {
  final List<DashboardAction> quickActions = const [
    DashboardAction(
      label: 'Deposit',
      icon: Icons.south_west_rounded,
      highlighted: true,
    ),
    DashboardAction(label: 'Transfer', icon: Icons.sync_alt_rounded),
    DashboardAction(label: 'Earn', icon: Icons.savings_outlined),
  ];

  final List<CryptoShortcut> cryptoShortcuts = const [
    CryptoShortcut(
      title: 'Bitcoin',
      imageAsset: AppAssets.bitcoin,
    ),
    CryptoShortcut(
      title: 'Ethereum',
      imageAsset: AppAssets.ethereum,
    ),
    CryptoShortcut(
      title: 'USDT',
      imageAsset: AppAssets.usdt,
    ),
    CryptoShortcut(
      title: 'USDC',
      imageAsset: AppAssets.usdc,
    ),
  ];

  final List<PopularCard> popularCards = const [
    PopularCard(name: 'Chime', rate: '₦1,194.76'),
    PopularCard(name: 'Apple (iTunes)', rate: '₦1,235.22'),
    PopularCard(name: 'Steam', rate: '₦1,330.99'),
    PopularCard(name: 'Razer Gold', rate: '₦1,123.82'),
    PopularCard(name: 'Sephora', rate: '₦1,119.91'),
    PopularCard(name: 'eBay', rate: '₦732.92'),
    PopularCard(name: 'Nordstrom', rate: '₦879.51'),
  ];

  String get greeting => 'Good morning!';
  String get userName => 'Adebanji';
  String get balanceLabel => 'Total Balance';
  String get balance => '₦56,893.30';
  String get profit => '+₦20,837.90';
  String get profitPercent => '+14.56%';
}

class DashboardAction {
  const DashboardAction({
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;
}

class CryptoShortcut {
  const CryptoShortcut({
    required this.title,
    required this.imageAsset,
  });

  final String title;
  final String imageAsset;
}

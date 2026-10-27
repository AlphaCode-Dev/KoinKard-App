import 'package:flutter/material.dart';
import 'package:koinkard/ui/views/assets/rates_viewmodel.dart';
import 'package:koinkard/ui/views/assets/widgets/rates_tab_switcher.dart';

class RatesHeader extends StatelessWidget {
  const RatesHeader({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final RatesTabType activeTab;
  final ValueChanged<RatesTabType> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return RatesTabSwitcher(
      activeTab: activeTab,
      onTabChanged: onTabChanged,
    );
  }
}

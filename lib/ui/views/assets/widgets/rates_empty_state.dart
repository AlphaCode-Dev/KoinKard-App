import 'package:flutter/material.dart';
import 'package:koinkard/ui/views/assets/rates_viewmodel.dart';

class RatesEmptyState extends StatelessWidget {
  const RatesEmptyState({
    super.key,
    required this.activeTab,
  });

  final RatesTabType activeTab;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

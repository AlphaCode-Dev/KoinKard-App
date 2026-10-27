import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/rates_view.dart';
import 'package:koinkard/ui/views/giftcard/giftcard_view.dart';
import 'package:koinkard/ui/views/home/home_view.dart';
import 'package:koinkard/ui/views/profile/profile_view.dart';
import 'package:koinkard/ui/views/trade/trade_view.dart';
import 'package:stacked/stacked.dart';

import 'bottomnavbar_viewmodel.dart';

class BottomnavbarView extends StackedView<BottomnavbarViewModel> {
  const BottomnavbarView({super.key});

  @override
  Widget builder(
    BuildContext context,
    BottomnavbarViewModel viewModel,
    Widget? child,
  ) {
    final pages = [
      const HomeView(),
      const RatesView(),
      const TradeView(),
      const GiftcardView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: List.generate(pages.length, (index) {
          if (!viewModel.hasVisitedTab(index)) {
            return const SizedBox.shrink();
          }
          return index == 0 ? pages[index] : SafeArea(child: pages[index]);
        }),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 14),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.fromLTRB(8, 9, 8, 7),
          decoration: BoxDecoration(
            color: AppColors.navigationSurface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.background.withValues(alpha: 0.38),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Row(
            children: List.generate(viewModel.items.length, (index) {
              final item = viewModel.items[index];
              final isSelected = index == viewModel.currentIndex;

              return Expanded(
                child: _BottomNavItem(
                  label: item.label,
                  icon: item.icon,
                  isSelected: isSelected,
                  onTap: () => viewModel.selectTab(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  BottomnavbarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomnavbarViewModel();
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: label == 'Trade'
                  ? AppColors.primary
                  : isSelected
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withValues(alpha: 0.38),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bottomNavLabel(selected: isSelected)
                  .copyWith(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textPrimary.withValues(alpha: 0.34)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/assets_view.dart';
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
      const AssetsView(),
      const TradeView(),
      const GiftcardView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: kDarkColor,
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: [
          pages[0],
          SafeArea(child: pages[1]),
          SafeArea(child: pages[2]),
          SafeArea(child: pages[3]),
          SafeArea(child: pages[4]),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 14),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.fromLTRB(8, 9, 8, 7),
          decoration: BoxDecoration(
            color: const Color(0xFF090A0B),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: kWhiteColor.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.38),
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: label == 'Trade'
                  ? kOrangeColor
                  : isSelected
                      ? kWhiteColor
                      : kWhiteColor.withValues(alpha: 0.38),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelXSmall.copyWith(
                color: isSelected
                    ? kWhiteColor
                    : kWhiteColor.withValues(alpha: 0.34),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

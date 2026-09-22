import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/views/home/widgets/asset_overview_card.dart';
import 'package:koinkard/ui/views/home/widgets/home_header.dart';
import 'package:koinkard/ui/views/home/widgets/market_snapshot_card.dart';
import 'package:koinkard/ui/views/home/widgets/promo_banner.dart';
import 'package:koinkard/ui/views/home/widgets/quick_actions_section.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 26),
              AssetOverviewCard(
                selectedCurrency: viewModel.selectedCurrency,
                supportedCurrencies: viewModel.supportedCurrencies,
                assetAmount: viewModel.selectedAssetBalance.amount,
                pnlAmount: viewModel.selectedAssetBalance.pnlAmount,
                pnlPercent: viewModel.selectedAssetBalance.pnlPercent,
                onCurrencyChanged: viewModel.selectCurrency,
              ),
              const SizedBox(height: 24),
              const QuickActionsSection(),
              const SizedBox(height: 24),
              const PromoBanner(),
              const SizedBox(height: 24),
              const MarketSnapshotCard(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_balance_section.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_empty_state.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_header.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_promo_card.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_quick_actions.dart';
import 'package:koinkard/ui/views/assets/widgets/assets_tab_switcher.dart';
import 'package:stacked/stacked.dart';

import 'assets_viewmodel.dart';

class AssetsView extends StackedView<AssetsViewModel> {
  const AssetsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AssetsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AssetsHeader(),
              const SizedBox(height: 28),
              AssetsBalanceSection(
                currencies: viewModel.supportedCurrencies,
                selectedCurrency: viewModel.selectedCurrency,
                selectedAmount: viewModel.selectedAssetBalance.amount,
                selectedCryptoAmount:
                    viewModel.selectedAssetBalance.cryptoAmount,
                selectedCryptoSymbol:
                    viewModel.selectedAssetBalance.cryptoSymbol,
                selectedPnl: viewModel.selectedAssetBalance.pnl,
                availableBalance:
                    viewModel.selectedAssetBalance.availableBalance,
                inUseBalance: viewModel.selectedAssetBalance.inUseBalance,
                onCurrencyChanged: viewModel.selectCurrency,
              ),
              const SizedBox(height: 20),
              const AssetsPromoCard(),
              const SizedBox(height: 28),
              const AssetsQuickActions(),
              const SizedBox(height: 28),
              AssetsTabSwitcher(
                activeTab: viewModel.activeTab,
                onTabChanged: viewModel.selectTab,
              ),
              const SizedBox(height: 56),
              AssetsEmptyState(
                activeTab: viewModel.activeTab,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AssetsViewModel viewModelBuilder(BuildContext context) => AssetsViewModel();
}

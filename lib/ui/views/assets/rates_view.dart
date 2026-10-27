import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/ui/views/assets/widgets/rates_balance_section.dart';
import 'package:koinkard/ui/views/assets/widgets/rates_header.dart';
import 'package:koinkard/ui/views/assets/widgets/rates_promo_card.dart';
import 'package:stacked/stacked.dart';

import 'rates_viewmodel.dart';

class RatesView extends StackedView<RatesViewModel> {
  const RatesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RatesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatesHeader(
                activeTab: viewModel.activeTab,
                onTabChanged: viewModel.selectTab,
              ),
              const SizedBox(height: 28),
              RatesBalanceSection(
                refreshCountdown: viewModel.refreshCountdown,
              ),
              Expanded(
                child: RatesPromoCard(
                  activeTab: viewModel.activeTab,
                  rates: viewModel.assetRates,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  RatesViewModel viewModelBuilder(BuildContext context) => RatesViewModel();
}

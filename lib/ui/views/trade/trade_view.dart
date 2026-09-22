import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_convert_footer.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_convert_mode_tabs.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_convert_pair_card.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_market_tabs.dart';
import 'package:stacked/stacked.dart';

import 'trade_viewmodel.dart';

class TradeView extends StackedView<TradeViewModel> {
  const TradeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TradeViewModel viewModel,
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
              TradeMarketTabs(
                activeTab: viewModel.activeMarketTab,
                onTabSelected: viewModel.selectMarketTab,
              ),
              const SizedBox(height: 28),
              TradeConvertModeTabs(
                activeMode: viewModel.activeConvertMode,
                onModeSelected: viewModel.selectConvertMode,
              ),
              const SizedBox(height: 18),
              TradeConvertPairCard(
                fromAsset: viewModel.fromAsset,
                toAsset: viewModel.toAsset,
                onSwapTap: viewModel.swapAssets,
              ),
              const SizedBox(height: 22),
              TradeConvertFooter(
                activeMarketTab: viewModel.activeMarketTab,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TradeViewModel viewModelBuilder(BuildContext context) => TradeViewModel();
}

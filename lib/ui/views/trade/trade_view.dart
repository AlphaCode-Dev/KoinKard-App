import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_convert_footer.dart';
import 'package:koinkard/ui/views/trade/widgets/trade_convert_pair_card.dart';
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sync_alt_rounded,
                      color: AppColors.background,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Convert',
                    style: AppTextStyles.pageHeading
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TradeConvertPairCard(
                fromAsset: viewModel.fromAsset,
                toAsset: viewModel.toAsset,
                onSwapTap: viewModel.swapAssets,
              ),
              const SizedBox(height: 22),
              const TradeConvertFooter(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TradeViewModel viewModelBuilder(BuildContext context) => TradeViewModel();
}

import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'giftcard_viewmodel.dart';
import 'widgets/giftcard_grid.dart';
import 'widgets/giftcard_sell_header.dart';

class GiftcardView extends StackedView<GiftcardViewModel> {
  const GiftcardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    GiftcardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GiftcardSellHeader(),
              ),
              const SizedBox(height: 24),
              Expanded(child: GiftcardGrid(cards: viewModel.cardBrands)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  GiftcardViewModel viewModelBuilder(BuildContext context) =>
      GiftcardViewModel();
}

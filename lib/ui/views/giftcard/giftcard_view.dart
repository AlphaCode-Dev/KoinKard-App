import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/ui/widgets/commons/striped_background.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.lightGradientTop,
        body: StripedBackground(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.zero,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GiftcardSellHeader(),
                const SizedBox(height: 24),
                Expanded(child: GiftcardGrid(cards: viewModel.cardBrands)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  GiftcardViewModel viewModelBuilder(BuildContext context) =>
      GiftcardViewModel();
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/views/giftcard/widgets/giftcard_sell_form.dart';
import 'package:koinkard/ui/views/giftcard/widgets/giftcard_sell_header.dart';
import 'package:koinkard/ui/views/giftcard/widgets/giftcard_sell_hero_card.dart';
import 'package:stacked/stacked.dart';

import 'giftcard_viewmodel.dart';

class GiftcardView extends StackedView<GiftcardViewModel> {
  const GiftcardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    GiftcardViewModel viewModel,
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
              const GiftcardSellHeader(),
              const SizedBox(height: 24),
              const GiftcardSellHeroCard(),
              const SizedBox(height: 24),
              GiftcardSellForm(
                selectedBrand: viewModel.selectedBrand,
                brands: viewModel.brands,
                selectedCountry: viewModel.selectedCountry,
                countries: viewModel.countries,
                selectedPayoutMethod: viewModel.selectedPayoutMethod,
                payoutMethods: viewModel.payoutMethods,
                amountController: viewModel.amountController,
                codeController: viewModel.codeController,
                onBrandSelected: viewModel.selectBrand,
                onCountrySelected: viewModel.selectCountry,
                onPayoutMethodSelected: viewModel.selectPayoutMethod,
              ),
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

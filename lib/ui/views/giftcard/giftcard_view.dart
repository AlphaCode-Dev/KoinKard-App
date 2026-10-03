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
  void onViewModelReady(GiftcardViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }

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
              if (viewModel.loadError != null && !viewModel.hasProducts) ...[
                _GiftcardLoadState(
                  message: viewModel.loadError!,
                  isLoading: viewModel.isLoadingProducts,
                  onRetry: viewModel.initialise,
                ),
              ] else if (!viewModel.hasProducts &&
                  viewModel.isLoadingProducts) ...[
                const _GiftcardLoadingState(),
              ] else if (!viewModel.hasProducts) ...[
                _GiftcardLoadState(
                  message: 'No gift card trade options are configured yet.',
                  isLoading: false,
                  onRetry: viewModel.initialise,
                ),
              ] else ...[
                GiftcardSellForm(
                  formKey: viewModel.formKey,
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
                  onAmountChanged: viewModel.onFieldChanged,
                  onCodeChanged: viewModel.onFieldChanged,
                  amountValidator: viewModel.validateAmount,
                  codeValidator: viewModel.validateCode,
                  autovalidateMode: viewModel.hasAttemptedSubmit
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  estimatedPayout: viewModel.estimatedPayoutLabel,
                  currentRate: viewModel.rateLabel,
                  settlementSpeed: viewModel.settlementSpeedLabel,
                  instructions: viewModel.selectedInstructions,
                  isSubmitting: viewModel.isSubmitting,
                  onSubmit: viewModel.canSubmit ? viewModel.submitTrade : null,
                ),
              ],
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

class _GiftcardLoadingState extends StatelessWidget {
  const _GiftcardLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: CircularProgressIndicator(
          color: kOrangeColor,
        ),
      ),
    );
  }
}

class _GiftcardLoadState extends StatelessWidget {
  const _GiftcardLoadState({
    required this.message,
    required this.isLoading,
    required this.onRetry,
  });

  final String message;
  final bool isLoading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF101112),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: kWhiteColor.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.wifi_tethering_error_rounded,
            color: kOrangeColor,
            size: 30,
          ),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kWhiteColor,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: isLoading ? null : onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: kOrangeColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

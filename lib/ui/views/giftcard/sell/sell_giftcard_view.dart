import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'sell_giftcard_viewmodel.dart';
import 'widgets/sell_giftcard_form.dart';
import 'widgets/sell_giftcard_footer.dart';

class SellGiftcardView extends StackedView<SellGiftcardViewModel> {
  const SellGiftcardView({super.key, required this.initialBrand});

  final String initialBrand;

  static Future<void> open(BuildContext context, String brand) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => SellGiftcardView(initialBrand: brand),
      ),
    );
  }

  @override
  Widget builder(
      BuildContext context, SellGiftcardViewModel viewModel, Widget? child) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.darkText,
          surfaceTintColor: AppColors.transparent,
          titleSpacing: 0,
          title: Text('Sell Cards', style: AppTextStyles.headingXSmall),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: SellGiftcardForm(viewModel: viewModel),
          ),
        ),
        bottomNavigationBar: SellGiftcardFooter(
          payout: viewModel.estimatedPayoutLabel,
          isSubmitting: viewModel.isSubmitting,
          onConfirm: viewModel.isLoadingProducts || viewModel.isSubmitting
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  if (!(viewModel.formKey.currentState?.validate() ?? false)) {
                    return;
                  }
                  final issue = viewModel.submissionIssue;
                  if (issue != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(issue)));
                    return;
                  }
                  await viewModel.submitTrade();
                },
        ),
      ),
    );
  }

  @override
  SellGiftcardViewModel viewModelBuilder(BuildContext context) =>
      SellGiftcardViewModel(initialBrand: initialBrand);

  @override
  void onViewModelReady(SellGiftcardViewModel viewModel) =>
      viewModel.initialise();
}

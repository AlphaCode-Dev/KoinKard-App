import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'screens/onboarding_bill_payment_screen.dart';
import 'screens/onboarding_giftcard_screen.dart';
import 'screens/onboarding_trade_screen.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({super.key});

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: PageView(
        controller: viewModel.pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          OnboardingTradeScreen(
            onNext: viewModel.nextPage,
            onSkip: viewModel.skipOnboarding,
          ),
          OnboardingGiftcardScreen(
            onNext: viewModel.nextPage,
            onSkip: viewModel.skipOnboarding,
          ),
          OnboardingBillPaymentScreen(
            onGetStarted: viewModel.completeOnboarding,
            onSkip: viewModel.skipOnboarding,
          ),
        ],
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();
}

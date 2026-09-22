import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';

import '../widgets/onboarding_illustration_widgets.dart';
import '../widgets/onboarding_page_template.dart';

class OnboardingTradeScreen extends StatelessWidget {
  const OnboardingTradeScreen({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageTemplate(
      pageIndex: 0,
      title: 'Trade Smarter.\nMove Freely.',
      description:
          'Buy, sell, and manage your crypto seamlessly at the best rates-all from one secure KoinKard wallet.',
      buttonLabel: 'Continue',
      onPrimaryTap: onNext,
      onSkip: onSkip,
      illustration: OnboardingIllustrationFrame(
        child: Image.asset(
          AppAssets.onboardingcoin,
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

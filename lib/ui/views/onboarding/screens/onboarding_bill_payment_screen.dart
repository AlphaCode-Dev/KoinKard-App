import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';

import '../widgets/onboarding_illustration_widgets.dart';
import '../widgets/onboarding_page_template.dart';

class OnboardingBillPaymentScreen extends StatelessWidget {
  const OnboardingBillPaymentScreen({
    super.key,
    required this.onGetStarted,
    required this.onSkip,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageTemplate(
      pageIndex: 2,
      title: 'Pay Bills.\nStay Connected.',
      description:
          'Pay for airtime, data, electricity, TV, and other essentials quickly-all from your KoinKard wallet.',
      buttonLabel: 'Get Started',
      onPrimaryTap: onGetStarted,
      onSkip: onSkip,
      showSkip: false,
      illustration: OnboardingIllustrationFrame(
        child: Image.asset(
          AppAssets.onboardingphonebills,
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

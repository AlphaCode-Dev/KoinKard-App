import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';

import '../widgets/onboarding_illustration_widgets.dart';
import '../widgets/onboarding_page_template.dart';

class OnboardingGiftcardScreen extends StatelessWidget {
  const OnboardingGiftcardScreen({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageTemplate(
      pageIndex: 1,
      title: 'Turn Gift Cards\nInto Cash.',
      description:
          'Trade your gift cards effortlessly at competitive rates and receive your money quickly and securely.',
      buttonLabel: 'Continue',
      onPrimaryTap: onNext,
      onSkip: onSkip,
      illustration: OnboardingIllustrationFrame(
        child: Image.asset(
          AppAssets.giftcard,
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

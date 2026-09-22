import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';

import '../../../common/app_colors.dart';
import 'onboarding_background.dart';
import 'onboarding_page_indicator.dart';

class OnboardingPageTemplate extends StatelessWidget {
  const OnboardingPageTemplate({
    super.key,
    required this.pageIndex,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.illustration,
    required this.onPrimaryTap,
    required this.onSkip,
    this.showSkip = true,
  });

  final int pageIndex;
  final String title;
  final String description;
  final String buttonLabel;
  final Widget illustration;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSkip;
  final bool showSkip;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.paddingOf(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        const OnboardingBackground(),
        Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            viewPadding.top + 20,
            24,
            viewPadding.bottom + 12,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.kklogo,
                          height: 32,
                          width: 120,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                        ),
                        const Spacer(),
                        if (showSkip)
                          TextButton(
                            onPressed: onSkip,
                            child: Text(
                              'Skip',
                              style: AppTextStyles.paragraphSmall.copyWith(
                                color: kOrangeColor,
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 68),
                      ],
                    ),
                    const Spacer(),
                    illustration,
                    const SizedBox(height: 36),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingLarge.copyWith(
                        color: kWhiteColor,
                        height: 1.12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.72),
                          height: 1.65,
                        ),
                      ),
                    ),
                    const Spacer(),
                    OnboardingPageIndicator(
                      pageIndex: pageIndex,
                      pageCount: 3,
                    ),
                    const SizedBox(height: 22),
                    KoinkardPrimaryButton(
                      text: buttonLabel,
                      height: 56,
                      backgroundColor: kOrangeColor,
                      textColor: kDarkColor,
                      onTap: onPrimaryTap,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

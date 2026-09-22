import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.pageIndex,
    required this.pageCount,
  });

  final int pageIndex;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == pageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                isActive ? kOrangeColor : kWhiteColor.withValues(alpha: 0.26),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

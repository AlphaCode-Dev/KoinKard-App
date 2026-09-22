import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';

import '../../../common/app_colors.dart';

class OnboardingIllustrationFrame extends StatelessWidget {
  const OnboardingIllustrationFrame({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 290,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  kOrangeColor.withValues(alpha: 0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class OnboardingLogoCard extends StatelessWidget {
  const OnboardingLogoCard({
    super.key,
    this.width = 220,
    this.height = 140,
    this.rotation = 0,
  });

  final double width;
  final double height;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.16),
              Colors.white.withValues(alpha: 0.04),
            ],
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.10),
          ),
          boxShadow: [
            BoxShadow(
              color: kOrangeColor.withValues(alpha: 0.24),
              blurRadius: 32,
              spreadRadius: 4,
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFF121212),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(
              AppAssets.kklogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingOrbitChip extends StatelessWidget {
  const OnboardingOrbitChip({
    super.key,
    required this.label,
    this.size = 58,
    this.backgroundColor,
    this.textColor,
  });

  final String label;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 10,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? const Color(0xFF181818),
          border: Border.all(
            color: kOrangeColor.withValues(alpha: 0.45),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: kOrangeColor.withValues(alpha: 0.22),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? kOrangeColor,
            fontSize: size * 0.24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class OnboardingPortalBase extends StatelessWidget {
  const OnboardingPortalBase({
    super.key,
    this.size = 170,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF141414),
        border: Border.all(
          color: kOrangeColor.withValues(alpha: 0.6),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: kOrangeColor.withValues(alpha: 0.26),
            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size * 0.62,
          height: size * 0.18,
          decoration: BoxDecoration(
            color: kOrangeColor.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: kOrangeColor.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}

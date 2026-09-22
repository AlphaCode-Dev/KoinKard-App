import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kDarkColor,
            const Color(0xFF111111),
            kDarkColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -80,
            child: _glowOrb(
              size: 280,
              color: kOrangeColor.withValues(alpha: 0.12),
            ),
          ),
          Positioned(
            right: -120,
            top: 160,
            child: _glowOrb(
              size: 260,
              color: kWhiteColor.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            bottom: -140,
            left: 30,
            child: _glowOrb(
              size: 240,
              color: kOrangeColor.withValues(alpha: 0.10),
            ),
          ),
          const Positioned(top: 86, left: 36, child: _Twinkle(size: 10)),
          const Positioned(top: 154, right: 52, child: _Twinkle(size: 14)),
          const Positioned(top: 332, left: 24, child: _Twinkle(size: 8)),
          const Positioned(top: 430, right: 40, child: _Twinkle(size: 12)),
          const Positioned(bottom: 210, left: 72, child: _Twinkle(size: 6)),
          const Positioned(bottom: 120, right: 82, child: _Twinkle(size: 8)),
        ],
      ),
    );
  }

  Widget _glowOrb({required double size, required Color color}) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _Twinkle extends StatelessWidget {
  const _Twinkle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: kWhiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kWhiteColor.withValues(alpha: 0.35),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

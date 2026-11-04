import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class VirtualCardFace extends StatelessWidget {
  const VirtualCardFace(
      {super.key,
      required this.number,
      required this.cardholder,
      required this.expiry});
  final String number;
  final String cardholder;
  final String expiry;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.586,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: 360,
            height: 227,
            child: CustomPaint(
              painter: const _CardArtwork(),
              child: Stack(children: [
                Positioned(
                    top: 12,
                    left: 24,
                    child: Image.asset(
                      AppAssets.kklogo,
                      width: 150,
                      height: 62,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                      semanticLabel: 'KoinKard',
                    )),
                Positioned(
                    top: 25,
                    right: 25,
                    child: Image.asset(AppAssets.virtualCardContactless,
                        width: 26,
                        height: 32,
                        fit: BoxFit.contain,
                        excludeFromSemantics: true)),
                Positioned(
                    top: 95,
                    left: 24,
                    child: Text('USD / VIRTUAL',
                        style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 8,
                            letterSpacing: 1.7,
                            color: AppColors.white.withValues(alpha: 0.60)))),
                Positioned(
                    left: 24,
                    top: 136,
                    right: 24,
                    child: Text(number,
                        style: const TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            color: AppColors.white,
                            fontSize: 19,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.w500))),
                Positioned(
                    left: 24,
                    bottom: 23,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CARDHOLDER',
                              style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 6,
                                  letterSpacing: 1.6,
                                  color:
                                      AppColors.white.withValues(alpha: 0.45))),
                          const SizedBox(height: 5),
                          Text(cardholder,
                              style: const TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 9,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white)),
                        ])),
                Positioned(
                    left: 178,
                    bottom: 23,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VALID THRU',
                              style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 6,
                                  letterSpacing: 1.3,
                                  color:
                                      AppColors.white.withValues(alpha: 0.45))),
                          const SizedBox(height: 5),
                          Text(expiry,
                              style: const TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 9,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white)),
                        ])),
                Positioned(
                    right: 24,
                    bottom: 22,
                    child: Image.asset(AppAssets.virtualCardVisa,
                        width: 66,
                        height: 25,
                        fit: BoxFit.contain,
                        excludeFromSemantics: true)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardArtwork extends CustomPainter {
  const _CardArtwork();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.background);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..color = AppColors.white.withValues(alpha: 0.10);
    // Offset orbital lines give the matte card its own engraved pattern.
    for (double radius = 54; radius <= 196; radius += 17) {
      canvas.drawArc(
          Rect.fromCircle(center: const Offset(340, -4), radius: radius),
          math.pi * 0.19,
          math.pi * 0.72,
          false,
          line);
    }
    final ribbon = Path()
      ..moveTo(255, 0)
      ..lineTo(276, 0)
      ..lineTo(327, 125)
      ..lineTo(306, 125)
      ..close();
    canvas.drawPath(ribbon, Paint()..color = AppColors.primary);
    canvas.drawLine(
        const Offset(248, 0),
        const Offset(298, 125),
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 1);
    canvas.drawLine(const Offset(24, 172), const Offset(336, 172), line);
  }

  @override
  bool shouldRepaint(covariant _CardArtwork oldDelegate) => false;
}

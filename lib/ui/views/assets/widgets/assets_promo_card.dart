import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class AssetsPromoCard extends StatelessWidget {
  const AssetsPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF0F0F2),
            Color(0xFFE8E8EA),
            Color(0xFFF7F7F8),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 40,
            top: 0,
            bottom: 0,
            child: CustomPaint(
              size: const Size(72, 72),
              painter: _PromoLinePainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Card',
                  style: AppTextStyles.paragraphLarge.copyWith(
                    color: const Color(0xFF171717),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Apply Now!',
                  style: AppTextStyles.paragraphMedium.copyWith(
                    color: const Color(0xFF787878),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kOrangeColor,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: kDarkColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.close,
                  size: 18,
                  color: const Color(0xFF696969),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4D4D8)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 8) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - 10, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

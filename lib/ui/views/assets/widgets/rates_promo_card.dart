import 'package:koinkard/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:koinkard/ui/views/assets/rates_viewmodel.dart';
import 'package:koinkard/ui/views/assets/widgets/rates_rate_tile.dart';

class RatesPromoCard extends StatelessWidget {
  const RatesPromoCard({
    super.key,
    required this.activeTab,
    required this.rates,
  });

  final RatesTabType activeTab;
  final List<RateItem> rates;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.lightGradientTop,
            AppColors.lightGradientMiddle,
            AppColors.lightGradientBottom,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: CustomPaint(
                  size: const Size(150, 900),
                  painter: _PromoStripePainter(),
                ),
              ),
            ),
            if (activeTab == RatesTabType.rates)
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                itemCount: rates.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) => RateTile(
                  item: rates[index],
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PromoStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.stripeOverlay
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (double x = -20; x < size.width + 50; x += 12) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - 80, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

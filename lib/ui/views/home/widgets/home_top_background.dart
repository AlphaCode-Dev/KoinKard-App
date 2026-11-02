import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class HomeTopBackground extends StatelessWidget {
  const HomeTopBackground({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius =
        const BorderRadius.vertical(bottom: Radius.circular(32)),
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: AppColors.homeHeaderSurface,
        child: CustomPaint(
          painter: const _HomeStripesPainter(),
          child: Padding(
            padding: padding ??
                EdgeInsets.fromLTRB(
                    16, topInset > 36 ? topInset + 16 : 52, 16, 22),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _HomeStripesPainter extends CustomPainter {
  const _HomeStripesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    final paint = Paint()
      ..color = AppColors.homeHeaderStripe
      ..strokeWidth = 0.8;
    for (double x = size.width * 0.54; x < size.width + 120; x += 12) {
      canvas.drawLine(Offset(x, 0), Offset(x - 80, size.height), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HomeStripesPainter oldDelegate) => false;
}

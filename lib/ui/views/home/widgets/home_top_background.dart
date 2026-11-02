import 'package:flutter/material.dart';

class HomeTopBackground extends StatelessWidget {
  const HomeTopBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      child: ColoredBox(
        color: const Color(0xFFFAFAFA),
        child: CustomPaint(
          painter: const _HomeStripesPainter(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
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
      ..color = const Color(0xFFECECEC)
      ..strokeWidth = 0.8;
    for (double x = size.width * 0.54; x < size.width + 120; x += 12) {
      canvas.drawLine(Offset(x, 0), Offset(x - 80, size.height), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HomeStripesPainter oldDelegate) => false;
}

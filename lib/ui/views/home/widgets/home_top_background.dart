import 'package:flutter/material.dart';
import 'package:koinkard/ui/widgets/commons/striped_background.dart';

class HomeTopBackground extends StatelessWidget {
  const HomeTopBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return StripedBackground(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      padding: EdgeInsets.fromLTRB(16, topInset + 14, 16, 24),
      child: child,
    );
  }
}

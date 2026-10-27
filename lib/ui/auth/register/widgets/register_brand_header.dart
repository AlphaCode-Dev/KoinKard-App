import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';

class RegisterBrandHeader extends StatelessWidget {
  const RegisterBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Center(
        child: Image.asset(
          AppAssets.kklogo,
          width: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class RegisterSocialButton extends StatelessWidget {
  const RegisterSocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF18191F),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kWhiteColor.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTextStyles.paragraphSmall.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

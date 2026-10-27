import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class LoginMethodToggle extends StatelessWidget {
  const LoginMethodToggle({
    super.key,
    required this.isEmailSelected,
    required this.onSelectEmail,
    required this.onSelectPhone,
  });

  final bool isEmailSelected;
  final VoidCallback onSelectEmail;
  final VoidCallback onSelectPhone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LoginMethodChip(
          label: 'Email',
          isSelected: isEmailSelected,
          onTap: onSelectEmail,
        ),
        const SizedBox(width: 10),
        _LoginMethodChip(
          label: 'Mobile number',
          isSelected: !isEmailSelected,
          onTap: onSelectPhone,
        ),
      ],
    );
  }
}

class _LoginMethodChip extends StatelessWidget {
  const _LoginMethodChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.selectedLoginMethod
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: AppTextStyles.loginTab(selected: isSelected).copyWith(
              color: isSelected
                  ? AppColors.textPrimary
                  : AppColors.textPrimary.withValues(alpha: 0.36)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class BillOption extends StatelessWidget {
  const BillOption(
      {super.key, required this.label, required this.asset, this.onTap});

  final String label;
  final String asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.rateTileBorder),
          ),
          child: Row(
            children: [
              ClipOval(
                  child: Image.asset(
                asset,
                width: 46,
                height: 46,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              )),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(label,
                      style: AppTextStyles.paragraphLarge.copyWith(
                        color: AppColors.darkText,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ))),
              const Icon(Icons.chevron_right,
                  color: AppColors.darkText, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class HomeServicesSection extends StatelessWidget {
  const HomeServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: _ServiceTile(
                label: 'Pay Bills', asset: AppAssets.homePayBills)),
        SizedBox(width: 8),
        Expanded(
            child: _ServiceTile(
                label: 'Virtual Card', asset: AppAssets.homeVirtualCard)),
        SizedBox(width: 8),
        Expanded(
            child: _ServiceTile(
                label: 'RMB Payment', asset: AppAssets.homeRmbPayment)),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.label, required this.asset});

  final String label;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2B2C30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: ClipRect(
              child: OverflowBox(
                maxWidth: 48,
                maxHeight: 48,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                      AppColors.cardSurface, BlendMode.screen),
                  child: Image.asset(asset,
                      width: 48, height: 48, excludeFromSemantics: true),
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(label,
              style: AppTextStyles.paragraphSmall.copyWith(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

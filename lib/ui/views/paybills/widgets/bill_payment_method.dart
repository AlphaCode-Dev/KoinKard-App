import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class BillPaymentMethod extends StatelessWidget {
  const BillPaymentMethod(
      {super.key, required this.currency, required this.onChanged});
  final String currency;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppColors.rateTileBorder)),
      child: Row(children: [
        const Expanded(
            child: Text('Select wallet',
                style: TextStyle(color: AppColors.balanceLabel, fontSize: 13))),
        Container(width: 1, height: 30, color: AppColors.rateTileBorder),
        const SizedBox(width: 10),
        Image.asset(currency == 'USDC' ? AppAssets.usdc : AppAssets.usdt,
            width: 20, height: 20),
        const SizedBox(width: 6),
        DropdownButton<String>(
            value: currency,
            underline: const SizedBox.shrink(),
            style: const TextStyle(
                fontFamily: AppTextStyles.fontFamily,
                color: AppColors.darkText,
                fontSize: 12),
            items: const [
              DropdownMenuItem(value: 'USDC', child: Text('USDC')),
              DropdownMenuItem(value: 'USDT', child: Text('USDT'))
            ],
            onChanged: onChanged),
      ]),
    );
  }
}

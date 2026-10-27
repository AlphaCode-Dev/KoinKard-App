import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';

class TradeConvertFooter extends StatelessWidget {
  const TradeConvertFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KoinkardPrimaryButton(
          text: 'Convert',
          height: 64,
          backgroundColor: AppColors.textPrimary,
          textColor: AppColors.background,
        ),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'One-Click Buy',
            style: AppTextStyles.paragraphMediumMedium
                .copyWith(color: AppColors.textPrimary.withValues(alpha: 0.34)),
          ),
        ),
      ],
    );
  }
}

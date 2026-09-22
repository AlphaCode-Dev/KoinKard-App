import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';

class TradeConvertFooter extends StatelessWidget {
  const TradeConvertFooter({
    super.key,
    required this.activeMarketTab,
  });

  final String activeMarketTab;

  @override
  Widget build(BuildContext context) {
    final isConvert = activeMarketTab == 'Convert';

    return Column(
      children: [
        KoinkardPrimaryButton(
          text: isConvert ? 'Deposit' : 'Open $activeMarketTab',
          height: 64,
          textColor: kDarkColor,
        ),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'One-Click Buy',
            style: AppTextStyles.paragraphMedium.copyWith(
              color: kWhiteColor.withValues(alpha: 0.34),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class VirtualCardHeader extends StatelessWidget {
  const VirtualCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5);
    // Keep the original heading height so the fitted card retains its size.
    final title = TextPainter(
      text: TextSpan(
          text: 'Cards',
          style: DefaultTextStyle.of(context).style.merge(titleStyle)),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    final height = title.height;
    title.dispose();
    return SizedBox(
        height: height,
        child: Row(children: [
          SizedBox(
              width: 28,
              height: height,
              child: IconButton(
                tooltip: 'Back',
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back,
                    color: AppColors.darkText, size: 20),
              )),
          const SizedBox(width: 6),
          const Expanded(child: Text('Cards', style: titleStyle)),
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightIconBorder),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
                widthFactor: 1,
                child: Text('Create new card',
                    style: TextStyle(
                        color: AppColors.darkText,
                        fontSize: 14,
                        fontWeight: FontWeight.w700))),
          ),
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class TradeMarketTabs extends StatelessWidget {
  const TradeMarketTabs({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final String activeTab;
  final ValueChanged<String> onTabSelected;

  static const _tabs = ['Convert', 'Spot', 'Futures', 'Options', 'Alpha'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kOrangeColor,
              ),
              child: const Icon(
                Icons.menu_rounded,
                size: 18,
                color: kDarkColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _tabs.map((tab) {
                    final isActive = tab == activeTab;
                    return Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: GestureDetector(
                        onTap: () => onTabSelected(tab),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tab,
                              style: AppTextStyles.paragraphLarge.copyWith(
                                color: isActive
                                    ? kWhiteColor
                                    : kWhiteColor.withValues(alpha: 0.26),
                                fontWeight: isActive
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                            if (tab == 'Alpha')
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFF4D6D),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

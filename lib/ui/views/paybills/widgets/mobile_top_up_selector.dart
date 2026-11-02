import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../paybills_viewmodel.dart';

class MobileTopUpSelector extends StatelessWidget {
  const MobileTopUpSelector(
      {super.key, required this.selected, required this.onChanged});

  final MobileTopUpType selected;
  final ValueChanged<MobileTopUpType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.lightGradientMiddle,
          borderRadius: BorderRadius.circular(14)),
      child: Row(
          children: MobileTopUpType.values.map((type) {
        final active = selected == type;
        return Expanded(
          child: Semantics(
            selected: active,
            child: Material(
              color: active ? AppColors.primary : AppColors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => onChanged(type),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    type == MobileTopUpType.airtime ? 'Airtime' : 'Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            active ? AppColors.white : AppColors.balanceLabel,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList()),
    );
  }
}

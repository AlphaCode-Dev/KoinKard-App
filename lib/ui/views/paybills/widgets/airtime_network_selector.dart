import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../paybills_viewmodel.dart';

class AirtimeNetworkSelector extends StatelessWidget {
  const AirtimeNetworkSelector(
      {super.key, required this.selected, required this.onChanged});

  final AirtimeNetwork selected;
  final ValueChanged<AirtimeNetwork> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: AirtimeNetwork.values.map((network) {
        final active = selected == network;
        return Semantics(
          selected: active,
          child: Tooltip(
            message: network.label,
            child: Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => onChanged(network),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 62,
                  height: 62,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color:
                            active ? AppColors.primary : AppColors.transparent),
                    boxShadow: active
                        ? [
                            BoxShadow(
                                color:
                                    AppColors.primary.withValues(alpha: 0.12),
                                blurRadius: 8)
                          ]
                        : null,
                  ),
                  child: ClipOval(
                      child: Image.asset(network.asset,
                          fit: BoxFit.cover, excludeFromSemantics: true)),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

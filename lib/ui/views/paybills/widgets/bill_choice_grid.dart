import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class BillChoiceGrid extends StatelessWidget {
  const BillChoiceGrid(
      {super.key,
      required this.labels,
      required this.details,
      required this.onSelected,
      this.selectedIndex = -1});
  final List<String> labels;
  final List<String> details;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          mainAxisExtent: 100),
      itemCount: labels.length,
      itemBuilder: (_, index) {
        final selected = index == selectedIndex;
        return Semantics(
            selected: selected,
            child: Material(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.08)
                  : AppColors.lightGradientMiddle,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: () => onSelected(index),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : AppColors.transparent)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(labels[index],
                                style: const TextStyle(
                                    color: AppColors.darkText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15))),
                        const SizedBox(height: 8),
                        Text(details[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColors.primary, fontSize: 11)),
                      ]),
                ),
              ),
            ));
      },
    );
  }
}

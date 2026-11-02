import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koinkard/common/app_colors.dart';
import '../paybills_viewmodel.dart';

class DataPlanSelector extends StatelessWidget {
  const DataPlanSelector({super.key, required this.model});
  final PaybillsViewModel model;

  @override
  Widget build(BuildContext context) {
    final plans = model.dataPlans;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: plans.isEmpty
          ? Column(children: [
              const Icon(Icons.wifi_outlined,
                  size: 32, color: AppColors.primary),
              const SizedBox(height: 12),
              Text('${model.network.label} data plans',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.darkText)),
              const SizedBox(height: 8),
              const Text(
                  'Data plans are currently unavailable. Please check back later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.balanceLabel, height: 1.5)),
            ])
          : Column(children: [
              if (plans.any((plan) => plan.isSample)) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Sample plans',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.balanceLabel)),
                ),
                const SizedBox(height: 12),
              ],
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 14,
                mainAxisExtent: 104,
                children: [
                  for (final plan in plans)
                    Semantics(
                      selected: model.selectedDataPlan == plan,
                      child: Material(
                        color: model.selectedDataPlan == plan
                            ? AppColors.primary.withValues(alpha: 0.08)
                            : AppColors.lightGradientMiddle,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () => model.selectDataPlan(plan),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(plan.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.darkText,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(plan.validity,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: AppColors.balanceLabel,
                                          fontSize: 10)),
                                  const SizedBox(height: 6),
                                  FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                          NumberFormat.currency(
                                                  locale: 'en_NG',
                                                  symbol: '₦',
                                                  decimalDigits: 0)
                                              .format(plan.priceNaira),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600))),
                                ]),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ]),
    );
  }
}

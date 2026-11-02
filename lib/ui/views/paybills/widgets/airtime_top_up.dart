import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_colors.dart';
import '../paybills_viewmodel.dart';

class AirtimeTopUp extends StatelessWidget {
  const AirtimeTopUp({super.key, required this.model});
  final PaybillsViewModel model;

  String _amount(int value) => value >= 1000
      ? '${value ~/ 1000},${(value % 1000).toString().padLeft(3, '0')}'
      : '$value';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _tab('For You', false),
            const SizedBox(width: 10),
            _tab('Popular', true),
          ]),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 10,
            childAspectRatio: 1.35,
            children: model.amounts.map((amount) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: model.amountController,
                builder: (_, value, __) {
                  final selected = double.tryParse(value.text) == amount;
                  return Material(
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : AppColors.lightGradientMiddle,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => model.selectAmount(amount),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.transparent),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text('₦${_amount(amount)}',
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const ValueKey('airtime-amount'),
            controller: model.amountController,
            validator: model.validateAmount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
            decoration: InputDecoration(
              hintText: '50–500,000',
              prefixIcon: const Center(
                  widthFactor: 1,
                  child: Text('₦', style: TextStyle(fontSize: 18))),
              suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                const Tooltip(
                    message:
                        'Amount in Nigerian naira. A payment quote is required before purchase.',
                    child: Icon(Icons.help_outline,
                        size: 17, color: AppColors.balanceLabel)),
                const SizedBox(width: 10),
                Text(model.currency,
                    style: const TextStyle(
                        color: AppColors.primary, fontSize: 12)),
                const SizedBox(width: 12),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, bool popular) {
    final selected = model.popular == popular;
    return InkWell(
      onTap: () => model.selectTab(popular),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.20)
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(8)),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color:
                      selected ? AppColors.darkText : AppColors.balanceLabel)),
        ),
      ),
    );
  }
}

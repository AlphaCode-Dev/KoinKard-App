import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';

class VirtualCardActions extends StatelessWidget {
  const VirtualCardActions(
      {super.key,
      required this.onDetails,
      required this.onTransactions,
      required this.onTerminate,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16)});
  final VoidCallback onDetails;
  final VoidCallback onTransactions;
  final VoidCallback onTerminate;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding,
      child: Row(children: [
        Expanded(
            child: _Action(
                label: 'Card details',
                icon: Icons.credit_card_outlined,
                onTap: onDetails)),
        const SizedBox(width: 8),
        Expanded(
            child: _Action(
                label: 'Transactions',
                icon: Icons.receipt_long_outlined,
                onTap: onTransactions)),
        const SizedBox(width: 8),
        Expanded(
            child: _Action(
                label: 'Terminate card',
                icon: Icons.delete_outline_rounded,
                onTap: onTerminate)),
      ]));
}

class _Action extends StatelessWidget {
  const _Action({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkText,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            side: const BorderSide(color: AppColors.lightIconBorder),
            shape: const StadiumBorder()),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightIconBorder)),
                  child: Icon(icon, size: 14)),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ])),
      ));
}

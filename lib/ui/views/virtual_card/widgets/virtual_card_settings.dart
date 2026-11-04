import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../virtual_card_viewmodel.dart';

class VirtualCardSettings extends StatelessWidget {
  const VirtualCardSettings({super.key, required this.model});
  final VirtualCardViewModel model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          children: [
            SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: const Text('Unfreeze card',
                  style: TextStyle(color: AppColors.darkText, fontSize: 16)),
              value: model.cardUnfrozen,
              activeTrackColor: AppColors.primary,
              activeThumbColor: AppColors.white,
              inactiveTrackColor: AppColors.lightIconBorder,
              onChanged: model.setCardUnfrozen,
            ),
            const Divider(height: 1, color: AppColors.rateTileBorder),
            _SettingRow(
                title: 'Card limits',
                onTap: () => _showDetails(context, 'Card limits',
                    'Your card limits will appear here when your virtual card is issued.')),
            const Divider(height: 1, color: AppColors.rateTileBorder),
            _SettingRow(
                title: 'Linked balances',
                onTap: () => _showDetails(context, 'Linked balances',
                    'You have no balances linked to this virtual card yet.')),
            const Divider(height: 1, color: AppColors.rateTileBorder),
            _SettingRow(
                title: 'View billing address',
                onTap: () => _showDetails(context, 'Billing address',
                    'Your billing address will appear here when your virtual card is issued.')),
          ],
        ));
  }

  void _showDetails(BuildContext context, String title, String message) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.homeHeaderSurface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (_) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(message,
                  style: const TextStyle(
                      color: AppColors.balanceLabel,
                      fontSize: 14,
                      height: 1.5)),
            ]),
      )),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        minTileHeight: 64,
        title: Text(title,
            style: const TextStyle(color: AppColors.darkText, fontSize: 16)),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppColors.balanceLabel, size: 26),
        onTap: onTap,
      );
}

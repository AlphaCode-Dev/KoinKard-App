import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'transfer_viewmodel.dart';
import 'widgets/transfer_option_card.dart';

class TransferView extends StackedView<TransferViewModel> {
  const TransferView({super.key});

  @override
  Widget builder(
      BuildContext context, TransferViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        foregroundColor: AppColors.darkText,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: Text('Transfer',
            style: AppTextStyles.headingXSmall.copyWith(
                color: AppColors.darkText, fontWeight: FontWeight.w500)),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
          children: [
            TransferOptionCard(
              title: 'KoinKard ID',
              subtitle: 'Send funds to a KoinKard user',
              badge: 'No Fee',
              badgeColor: AppColors.transferNoFeeSurface.withValues(alpha: 0.7),
              badgeBorderColor: AppColors.transferNoFeeBorder,
              badgeTextColor: AppColors.white,
              icon: ClipOval(
                  child: Image.asset(AppAssets.appicon, fit: BoxFit.cover)),
            ),
            const SizedBox(height: 12),
            const TransferOptionCard(
              title: 'Bank Account',
              subtitle: 'Transfer to bank account',
              icon: Icon(Icons.account_balance_outlined,
                  color: AppColors.darkText, size: 24),
            ),
            const SizedBox(height: 12),
            TransferOptionCard(
              title: 'Stablecoins',
              subtitle: 'Send USDT and USDC instantly',
              badge: 'New',
              badgeColor: AppColors.usdCoinRing,
              badgeBorderColor: AppColors.usdCoin.withValues(alpha: 0.2),
              icon: Image.asset(AppAssets.usdc, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }

  @override
  TransferViewModel viewModelBuilder(BuildContext context) =>
      TransferViewModel();
}

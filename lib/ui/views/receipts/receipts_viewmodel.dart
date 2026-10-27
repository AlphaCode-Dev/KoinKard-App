import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'models/recent_transaction.dart';

class ReceiptsViewModel extends BaseViewModel {
  final List<RecentTransaction> recentTransactions = const [
    RecentTransaction(
      title: 'Electricity Payment',
      subtitle: 'IKEDC • Today, 09:24 AM',
      amount: '-₦12,500',
      status: 'Completed',
      isCredit: false,
      accentColor: AppColors.electricityAccent,
      icon: Icons.bolt_rounded,
    ),
    RecentTransaction(
      title: 'Wallet Funding',
      subtitle: 'Bank Transfer • Today, 08:10 AM',
      amount: '+₦50,000',
      status: 'Completed',
      isCredit: true,
      accentColor: AppColors.fundingAccent,
      icon: Icons.south_west_rounded,
    ),
    RecentTransaction(
      title: 'Airtime Purchase',
      subtitle: 'MTN • Yesterday, 06:42 PM',
      amount: '-₦2,000',
      status: 'Completed',
      isCredit: false,
      accentColor: AppColors.airtimeAccent,
      icon: Icons.phone_iphone_rounded,
    ),
    RecentTransaction(
      title: 'Cable TV Renewal',
      subtitle: 'DStv • Yesterday, 01:18 PM',
      amount: '-₦9,800',
      status: 'Completed',
      isCredit: false,
      accentColor: AppColors.primary,
      icon: Icons.live_tv_rounded,
    ),
  ];
}

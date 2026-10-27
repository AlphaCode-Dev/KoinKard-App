import 'package:koinkard/common/app_colors.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RatesViewModel extends BaseViewModel {
  RatesViewModel() {
    _startRefreshCountdown();
  }

  final List<RateCurrencyBalance> _balances = const [
    RateCurrencyBalance(
      currency: 'USD',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
    RateCurrencyBalance(
      currency: 'NGN',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
    RateCurrencyBalance(
      currency: 'EUR',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
  ];

  final List<RateItem> assetRates = const [
    RateItem(
      symbol: 'USDT',
      rate: '₦1,357',
      badgeText: 'T',
      badgeColor: AppColors.tether,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.tetherRing,
    ),
    RateItem(
      symbol: 'USDC',
      rate: '₦1,357',
      badgeText: 'C',
      badgeColor: AppColors.usdCoin,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.usdCoinRing,
    ),
    RateItem(
      symbol: 'BTC',
      rate: '₦1,352',
      badgeText: '₿',
      badgeColor: AppColors.bitcoin,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.bitcoinRing,
    ),
    RateItem(
      symbol: 'ETH',
      rate: '₦1,352',
      badgeText: 'Ξ',
      badgeColor: AppColors.ethereum,
      badgeTextColor: AppColors.ethereumText,
      badgeRingColor: AppColors.ethereumRing,
    ),
    RateItem(
      symbol: 'BNB',
      rate: '₦1,352',
      badgeText: 'B',
      badgeColor: AppColors.binance,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.binanceRing,
    ),
    RateItem(
      symbol: 'SOL',
      rate: '₦1,352',
      badgeText: 'S',
      badgeColor: AppColors.solanaSurface,
      badgeTextColor: AppColors.solana,
      badgeRingColor: AppColors.solanaRing,
    ),
    RateItem(
      symbol: 'GRAM',
      rate: '₦1,347',
      badgeText: 'G',
      badgeColor: AppColors.gram,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.gramRing,
    ),
    RateItem(
      symbol: 'TRX',
      rate: '₦1,347',
      badgeText: 'T',
      badgeColor: AppColors.tron,
      badgeTextColor: AppColors.white,
      badgeRingColor: AppColors.tronRing,
    ),
  ];

  String _selectedCurrency = 'USD';
  RatesTabType _activeTab = RatesTabType.rates;
  Timer? _refreshTimer;
  int _remainingSeconds = 30;

  List<String> get supportedCurrencies =>
      _balances.map((balance) => balance.currency).toList();

  String get selectedCurrency => _selectedCurrency;

  RatesTabType get activeTab => _activeTab;

  String get refreshCountdown {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  RateCurrencyBalance get selectedAssetBalance => _balances.firstWhere(
        (balance) => balance.currency == _selectedCurrency,
        orElse: () => _balances.first,
      );

  void _startRefreshCountdown() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds == 0) {
        _remainingSeconds = 30;
      } else {
        _remainingSeconds -= 1;
      }
      rebuildUi();
    });
  }

  void selectCurrency(String? currency) {
    if (currency == null || currency == _selectedCurrency) return;
    _selectedCurrency = currency;
    rebuildUi();
  }

  void selectTab(RatesTabType tab) {
    if (tab == _activeTab) return;
    _activeTab = tab;
    rebuildUi();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}

enum RatesTabType { rates, calculator }

class RateCurrencyBalance {
  const RateCurrencyBalance({
    required this.currency,
    required this.amount,
    required this.cryptoAmount,
    required this.cryptoSymbol,
    required this.pnl,
    required this.availableBalance,
    required this.inUseBalance,
  });

  final String currency;
  final String amount;
  final String cryptoAmount;
  final String cryptoSymbol;
  final String pnl;
  final String availableBalance;
  final String inUseBalance;
}

class RateItem {
  const RateItem({
    required this.symbol,
    required this.rate,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.badgeRingColor,
  });

  final String symbol;
  final String rate;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;
  final Color badgeRingColor;
}

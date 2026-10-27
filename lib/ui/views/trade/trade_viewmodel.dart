import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:stacked/stacked.dart';

class TradeViewModel extends BaseViewModel {
  TradeConvertMode _activeConvertMode = TradeConvertMode.instant;
  TradeAssetData _fromAsset = const TradeAssetData(
    symbol: 'BTC',
    color: AppColors.bitcoin,
    availableBalance: '0',
    amountDisplay: '0.0000001-100',
    trailingLabel: 'Max',
  );
  TradeAssetData _toAsset = const TradeAssetData(
    symbol: 'USDC',
    color: AppColors.usdCoin,
    availableBalance: '0',
    amountDisplay: '--',
    trailingLabel: '--',
  );

  TradeConvertMode get activeConvertMode => _activeConvertMode;
  TradeAssetData get fromAsset => _fromAsset;
  TradeAssetData get toAsset => _toAsset;

  void selectConvertMode(TradeConvertMode mode) {
    if (mode == _activeConvertMode) return;
    _activeConvertMode = mode;
    rebuildUi();
  }

  void swapAssets() {
    final currentFrom = _fromAsset;
    _fromAsset = _toAsset;
    _toAsset = currentFrom;
    rebuildUi();
  }
}

enum TradeConvertMode { instant, limit }

class TradeAssetData {
  const TradeAssetData({
    required this.symbol,
    required this.color,
    required this.availableBalance,
    required this.amountDisplay,
    required this.trailingLabel,
  });

  final String symbol;
  final Color color;
  final String availableBalance;
  final String amountDisplay;
  final String trailingLabel;
}

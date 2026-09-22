import 'package:stacked/stacked.dart';

class TradeViewModel extends BaseViewModel {
  final List<String> _marketTabs = const [
    'Convert',
    'Spot',
    'Futures',
    'Options',
    'Alpha',
  ];

  String _activeMarketTab = 'Convert';
  TradeConvertMode _activeConvertMode = TradeConvertMode.instant;
  TradeAssetData _fromAsset = const TradeAssetData(
    symbol: 'BTC',
    colorHex: 0xFFF7931A,
    availableBalance: '0',
    amountDisplay: '0.0000001-100',
    trailingLabel: 'Max',
  );
  TradeAssetData _toAsset = const TradeAssetData(
    symbol: 'USDC',
    colorHex: 0xFF2775CA,
    availableBalance: '0',
    amountDisplay: '--',
    trailingLabel: '--',
  );

  List<String> get marketTabs => _marketTabs;
  String get activeMarketTab => _activeMarketTab;
  TradeConvertMode get activeConvertMode => _activeConvertMode;
  TradeAssetData get fromAsset => _fromAsset;
  TradeAssetData get toAsset => _toAsset;

  void selectMarketTab(String tab) {
    if (tab == _activeMarketTab) return;
    _activeMarketTab = tab;
    rebuildUi();
  }

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
    required this.colorHex,
    required this.availableBalance,
    required this.amountDisplay,
    required this.trailingLabel,
  });

  final String symbol;
  final int colorHex;
  final String availableBalance;
  final String amountDisplay;
  final String trailingLabel;
}

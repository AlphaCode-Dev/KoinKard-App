import 'package:stacked/stacked.dart';

class AssetsViewModel extends BaseViewModel {
  final List<AssetCurrencyBalance> _balances = const [
    AssetCurrencyBalance(
      currency: 'USD',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
    AssetCurrencyBalance(
      currency: 'NGN',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
    AssetCurrencyBalance(
      currency: 'EUR',
      amount: '0.00',
      cryptoAmount: '0.00000000',
      cryptoSymbol: 'BTC',
      pnl: '--',
      availableBalance: '0.00',
      inUseBalance: '0.00',
    ),
  ];

  String _selectedCurrency = 'USD';
  AssetsTabType _activeTab = AssetsTabType.asset;

  List<String> get supportedCurrencies =>
      _balances.map((balance) => balance.currency).toList();

  String get selectedCurrency => _selectedCurrency;

  AssetsTabType get activeTab => _activeTab;

  AssetCurrencyBalance get selectedAssetBalance => _balances.firstWhere(
        (balance) => balance.currency == _selectedCurrency,
        orElse: () => _balances.first,
      );

  void selectCurrency(String? currency) {
    if (currency == null || currency == _selectedCurrency) return;
    _selectedCurrency = currency;
    rebuildUi();
  }

  void selectTab(AssetsTabType tab) {
    if (tab == _activeTab) return;
    _activeTab = tab;
    rebuildUi();
  }
}

enum AssetsTabType { asset, account }

class AssetCurrencyBalance {
  const AssetCurrencyBalance({
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

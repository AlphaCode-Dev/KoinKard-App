import 'package:koinkard/app/app.bottomsheets.dart';
import 'package:koinkard/app/app.dialogs.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';

  final List<AssetBalanceData> _assetBalances = const [
    AssetBalanceData(
      currency: 'USD',
      amount: '0.00',
      pnlAmount: '0.00',
      pnlPercent: '0.00%',
    ),
    AssetBalanceData(
      currency: 'NGN',
      amount: '0.00',
      pnlAmount: '0.00',
      pnlPercent: '0.00%',
    ),
    AssetBalanceData(
      currency: 'EUR',
      amount: '0.00',
      pnlAmount: '0.00',
      pnlPercent: '0.00%',
    ),
    AssetBalanceData(
      currency: 'GBP',
      amount: '0.00',
      pnlAmount: '0.00',
      pnlPercent: '0.00%',
    ),
  ];

  int _counter = 0;
  String _selectedCurrency = 'USD';

  List<String> get supportedCurrencies =>
      _assetBalances.map((balance) => balance.currency).toList();

  String get selectedCurrency => _selectedCurrency;

  AssetBalanceData get selectedAssetBalance => _assetBalances.firstWhere(
        (balance) => balance.currency == _selectedCurrency,
        orElse: () => _assetBalances.first,
      );

  void selectCurrency(String? currency) {
    if (currency == null || currency == _selectedCurrency) return;
    _selectedCurrency = currency;
    rebuildUi();
  }

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}

class AssetBalanceData {
  const AssetBalanceData({
    required this.currency,
    required this.amount,
    required this.pnlAmount,
    required this.pnlPercent,
  });

  final String currency;
  final String amount;
  final String pnlAmount;
  final String pnlPercent;
}

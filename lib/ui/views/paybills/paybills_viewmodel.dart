import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:stacked/stacked.dart';

enum AirtimeNetwork {
  mtn('MTN', AppAssets.mtn),
  airtel('Airtel', AppAssets.airtel),
  glo('Glo', AppAssets.glo),
  nineMobile('9mobile', AppAssets.nineMobile);

  const AirtimeNetwork(this.label, this.asset);
  final String label;
  final String asset;
}

class PaybillsViewModel extends BaseViewModel {
  PaybillsViewModel({this.network = AirtimeNetwork.mtn});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  AirtimeNetwork network;
  String currency = 'USDC';
  bool popular = false;

  List<int> get amounts => popular
      ? const [500, 1000, 2000, 3000, 5000, 10000]
      : const [50, 100, 200, 500, 1000, 2000];

  void selectNetwork(AirtimeNetwork value) {
    network = value;
    notifyListeners();
  }

  void selectAmount(int value) {
    amountController.text = '$value';
    notifyListeners();
  }

  void selectCurrency(String? value) {
    if (value == null) return;
    currency = value;
    notifyListeners();
  }

  void selectTab(bool value) {
    popular = value;
    notifyListeners();
  }

  String? validatePhone(String? value) {
    final phone = (value ?? '').trim();
    return RegExp(r'^(0[789]\d{9}|[789]\d{9})$').hasMatch(phone)
        ? null
        : 'Enter a valid Nigerian phone number.';
  }

  String? validateAmount(String? value) {
    final amount = double.tryParse(value ?? '');
    return amount != null && amount.isFinite && amount >= 50 && amount <= 500000
        ? null
        : 'Enter an amount from ₦50 to ₦500,000.';
  }

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }
}

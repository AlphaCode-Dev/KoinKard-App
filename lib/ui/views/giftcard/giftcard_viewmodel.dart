import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GiftcardViewModel extends BaseViewModel {
  GiftcardViewModel();

  final amountController = TextEditingController();
  final codeController = TextEditingController();

  final List<String> brands = const [
    'Amazon',
    'iTunes',
    'Steam',
    'Visa',
  ];

  final List<String> countries = const [
    'United States',
    'United Kingdom',
    'Canada',
    'Germany',
  ];

  final List<String> payoutMethods = const [
    'Wallet Balance',
    'Bank Transfer',
    'USDT',
  ];

  String _selectedBrand = 'Amazon';
  String _selectedCountry = 'United States';
  String _selectedPayoutMethod = 'Wallet Balance';

  String get selectedBrand => _selectedBrand;
  String get selectedCountry => _selectedCountry;
  String get selectedPayoutMethod => _selectedPayoutMethod;

  void selectBrand(String brand) {
    if (brand == _selectedBrand) return;
    _selectedBrand = brand;
    rebuildUi();
  }

  void selectCountry(String? country) {
    if (country == null || country == _selectedCountry) return;
    _selectedCountry = country;
    rebuildUi();
  }

  void selectPayoutMethod(String? payoutMethod) {
    if (payoutMethod == null || payoutMethod == _selectedPayoutMethod) return;
    _selectedPayoutMethod = payoutMethod;
    rebuildUi();
  }

  @override
  void dispose() {
    amountController.dispose();
    codeController.dispose();
    super.dispose();
  }
}

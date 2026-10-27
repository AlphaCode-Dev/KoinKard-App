import 'package:flutter/material.dart';
import 'package:koinkard/app/app.dialogs.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/models/giftcard/giftcard_order_request_model.dart';
import 'package:koinkard/data/models/giftcard/giftcard_product_model.dart';
import 'package:koinkard/data/services/giftcard/giftcard_trade_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GiftcardViewModel extends BaseViewModel {
  GiftcardViewModel();

  final List<String> cardBrands = const [
    'Chime',
    'Apple (iTunes)',
    'Steam',
    'Razer Gold',
    'Sephora',
    'eBay',
    'Nordstrom',
  ];

  final _giftcardTradeService = locator<GiftcardTradeService>();
  final _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final codeController = TextEditingController();

  final List<String> payoutMethods = const ['Wallet Balance'];

  final List<GiftcardProductModel> _giftcardProducts = [];
  String _selectedBrand = '';
  String _selectedCountry = 'Global';
  String _selectedPayoutMethod = 'Wallet Balance';
  String? _loadError;
  bool _isLoadingProducts = false;
  bool _isSubmitting = false;
  bool hasAttemptedSubmit = false;

  List<String> get brands =>
      _giftcardProducts.map((product) => product.brandLabel).toSet().toList();

  List<GiftcardProductModel> get productsForSelectedBrand => _giftcardProducts
      .where((product) =>
          GiftcardProductModel.brandKey(product.brandLabel) ==
          GiftcardProductModel.brandKey(selectedBrand))
      .toList();

  List<String> get countries => productsForSelectedBrand
      .map((product) => product.countryLabel)
      .toSet()
      .toList();

  String get selectedBrand => _selectedBrand;
  String get selectedCountry => _selectedCountry;
  String get selectedPayoutMethod => _selectedPayoutMethod;
  String? get loadError => _loadError;
  bool get isLoadingProducts => _isLoadingProducts;
  bool get isSubmitting => _isSubmitting;
  bool get hasProducts => _giftcardProducts.isNotEmpty;

  GiftcardProductModel? get selectedProduct {
    for (final product in productsForSelectedBrand) {
      if (product.countryLabel == _selectedCountry) {
        return product;
      }
    }
    return null;
  }

  String get payoutMethodValue => 'wallet';

  double get enteredAmount =>
      double.tryParse(amountController.text.trim().replaceAll(',', '')) ?? 0;

  double get estimatedPayoutValue {
    final product = selectedProduct;
    if (product == null) {
      return 0;
    }
    return enteredAmount * product.activeRate;
  }

  String get estimatedPayoutLabel => estimatedPayoutValue.toStringAsFixed(2);

  String get rateLabel {
    final product = selectedProduct;
    if (product == null) {
      return '--';
    }
    return '${product.activeRate.toStringAsFixed(2)} NGN / 1 unit';
  }

  String get settlementSpeedLabel => selectedPayoutMethod == 'Wallet Balance'
      ? 'Wallet credit after review'
      : 'Pending payout routing';

  String get selectedInstructions {
    final product = selectedProduct;
    if (product == null || product.instructions.trim().isEmpty) {
      return 'Submit your gift card details and we will route the trade for review.';
    }
    return product.instructions.trim();
  }

  bool get canSubmit =>
      !_isLoadingProducts &&
      !_isSubmitting &&
      selectedProduct != null &&
      amountController.text.trim().isNotEmpty &&
      codeController.text.trim().isNotEmpty;

  Future<void> initialise() async {
    _isLoadingProducts = true;
    _loadError = null;
    rebuildUi();

    final result = await _giftcardTradeService.fetchCommerce();

    _isLoadingProducts = false;

    if (result.isFailure || result.data == null) {
      _loadError = result.message ?? 'Unable to load gift card trade options.';
      rebuildUi();
      return;
    }

    _giftcardProducts
      ..clear()
      ..addAll(
          result.data!.giftcardProducts.where((product) => product.enabled));
    _syncSelections();
    rebuildUi();
  }

  void onFieldChanged(String _) {
    rebuildUi();
  }

  void selectBrand(String brand) {
    if (brand == _selectedBrand) return;
    _selectedBrand = brand;
    final nextCountries = countries;
    _selectedCountry = nextCountries.isEmpty ? 'Global' : nextCountries.first;
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

  String? validateAmount(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Card amount is required.';
    }

    final amount = double.tryParse(input.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      return 'Enter a valid card amount.';
    }
    return null;
  }

  String? validateCode(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Provide the card code or proof reference.';
    }
    if (input.length < 3) {
      return 'Add more details for this trade.';
    }
    return null;
  }

  Future<void> submitTrade() async {
    hasAttemptedSubmit = true;
    rebuildUi();

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final product = selectedProduct;
    if (product == null) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Trade unavailable',
        description:
            'There is no gift card product configured for this selection yet.',
      );
      return;
    }

    _isSubmitting = true;
    rebuildUi();

    final reference = codeController.text.trim();
    final result = await _giftcardTradeService.createOrder(
      GiftcardOrderRequestModel(
        productId: product.id,
        amount: amountController.text.trim(),
        digitalCode: _looksLikeProofReference(reference) ? '' : reference,
        proofReference: _looksLikeProofReference(reference) ? reference : '',
        payoutMethod: payoutMethodValue,
      ),
    );

    _isSubmitting = false;
    rebuildUi();

    if (result.isFailure || result.data == null) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Trade failed',
        description:
            result.message ?? 'We could not submit this gift card trade.',
      );
      return;
    }

    amountController.clear();
    codeController.clear();
    hasAttemptedSubmit = false;
    rebuildUi();

    await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Trade submitted',
      description:
          'Order #${result.data!.id} is ${result.data!.status}. Estimated payout: ${result.data!.payoutNgn} NGN.',
    );
  }

  bool _looksLikeProofReference(String value) {
    final input = value.toLowerCase();
    return input.startsWith('http://') ||
        input.startsWith('https://') ||
        input.startsWith('data:') ||
        input.contains('receipt') ||
        input.contains('proof');
  }

  void _syncSelections() {
    if (_giftcardProducts.isEmpty) {
      _selectedCountry = 'Global';
      return;
    }

    if (_selectedBrand.isEmpty) {
      _selectedBrand = brands.first;
    }
    _selectedCountry = countries.isEmpty ? 'Global' : countries.first;
  }

  @override
  void dispose() {
    amountController.dispose();
    codeController.dispose();
    super.dispose();
  }
}

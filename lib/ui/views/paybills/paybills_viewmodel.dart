import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'models/airtime_network.dart';
import 'models/mobile_data_plan.dart';
import 'models/sample_data_plans.dart';
import 'models/utility_bill_options.dart';

export 'models/airtime_network.dart';
export 'models/mobile_data_plan.dart';
export 'models/utility_bill_options.dart';

enum MobileTopUpType { airtime, data }

class PaybillsViewModel extends BaseViewModel {
  PaybillsViewModel({this.network = AirtimeNetwork.mtn});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final televisionFormKey = GlobalKey<FormState>();
  final electricityFormKey = GlobalKey<FormState>();
  final smartcardController = TextEditingController();
  final meterController = TextEditingController();
  final electricityAmountController = TextEditingController();
  TelevisionProvider televisionProvider = TelevisionProvider.dstv;
  ElectricityProvider electricityProvider = ElectricityProvider.ikeja;
  ElectricityMeterType meterType = ElectricityMeterType.prepaid;
  TelevisionPackage? selectedTelevisionPackage;

  List<TelevisionPackage> get televisionPackages => sampleTelevisionPackages
      .where((package) => package.provider == televisionProvider)
      .toList(growable: false);
  List<int> get electricityAmounts =>
      const [1000, 2000, 5000, 10000, 20000, 50000];

  void selectTelevisionProvider(TelevisionProvider? value) {
    if (value == null || value == televisionProvider) return;
    televisionProvider = value;
    selectedTelevisionPackage = null;
    smartcardController.clear();
    notifyListeners();
  }

  void selectTelevisionPackage(TelevisionPackage package) {
    if (!televisionPackages.contains(package)) return;
    selectedTelevisionPackage = package;
    notifyListeners();
  }

  void selectElectricityProvider(ElectricityProvider? value) {
    if (value == null || value == electricityProvider) return;
    electricityProvider = value;
    meterController.clear();
    notifyListeners();
  }

  void selectMeterType(ElectricityMeterType value) {
    meterType = value;
    meterController.clear();
    notifyListeners();
  }

  void selectElectricityAmount(int value) {
    electricityAmountController.text = '$value';
    notifyListeners();
  }

  String? validateSmartcard(String? value) =>
      RegExp(r'^\d{8,14}$').hasMatch((value ?? '').trim())
          ? null
          : 'Enter a valid smartcard or IUC number.';

  String? validateMeter(String? value) =>
      RegExp(r'^\d{6,20}$').hasMatch((value ?? '').trim())
          ? null
          : 'Enter a valid meter or account number.';

  String? validateElectricityAmount(String? value) {
    final amount = double.tryParse(value ?? '');
    return amount != null &&
            amount.isFinite &&
            amount >= 1000 &&
            amount <= 500000
        ? null
        : 'Enter an amount from ₦1,000 to ₦500,000.';
  }

  AirtimeNetwork network;
  String currency = 'USDC';
  bool popular = false;
  MobileTopUpType topUpType = MobileTopUpType.airtime;
  List<MobileDataPlan> _dataPlans = sampleDataPlans;
  MobileDataPlan? _selectedDataPlan;

  bool get isData => topUpType == MobileTopUpType.data;
  MobileDataPlan? get selectedDataPlan => _selectedDataPlan;
  List<MobileDataPlan> get dataPlans => _dataPlans
      .where((plan) =>
          plan.network == network &&
          plan.enabled &&
          plan.priceNaira.isFinite &&
          plan.priceNaira > 0)
      .toList(growable: false);

  void selectTopUpType(MobileTopUpType value) {
    topUpType = value;
    notifyListeners();
  }

  void updateDataPlans(List<MobileDataPlan> plans) {
    _dataPlans = List.unmodifiable(plans);
    // Quotes must be selected again when the provider refreshes its catalog.
    _selectedDataPlan = null;
    notifyListeners();
  }

  void selectDataPlan(MobileDataPlan plan) {
    if (!dataPlans.contains(plan)) return;
    _selectedDataPlan = plan;
    notifyListeners();
  }

  List<int> get amounts => popular
      ? const [500, 1000, 2000, 3000, 5000, 10000]
      : const [50, 100, 200, 500, 1000, 2000];

  void selectNetwork(AirtimeNetwork value) {
    if (network == value) return;
    network = value;
    _selectedDataPlan = null;
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
    smartcardController.dispose();
    meterController.dispose();
    electricityAmountController.dispose();
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }
}

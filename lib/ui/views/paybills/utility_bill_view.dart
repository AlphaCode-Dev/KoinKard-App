import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';
import '../home/widgets/home_top_background.dart';
import 'paybills_viewmodel.dart';
import 'widgets/bill_choice_grid.dart';
import 'widgets/bill_payment_method.dart';
import 'widgets/bill_provider_dropdown.dart';

class UtilityBillView extends StackedView<PaybillsViewModel> {
  const UtilityBillView(
      {super.key, required this.viewModel, required this.type});
  final PaybillsViewModel viewModel;
  final UtilityBillType type;

  @override
  bool get disposeViewModel => false;

  @override
  PaybillsViewModel viewModelBuilder(BuildContext context) => viewModel;

  @override
  Widget builder(BuildContext context, PaybillsViewModel model, Widget? child) {
    final isTv = type == UtilityBillType.television;
    final title = isTv ? 'TV Subscription' : 'Electricity';
    final money =
        NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 0);
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.rateTileBorder));
    final packages = model.televisionPackages;
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary, brightness: Brightness.light),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: border,
          enabledBorder: border,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: AppColors.primary)),
          hintStyle:
              const TextStyle(color: AppColors.greetingText, fontSize: 13),
        ),
      ),
      child: HomeTopBackground(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.darkText,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light),
            title: Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          body: SafeArea(
              top: false,
              child: Form(
                key: isTv ? model.televisionFormKey : model.electricityFormKey,
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
                    children: [
                      _label(isTv ? 'TV Provider' : 'Electricity Provider'),
                      if (isTv)
                        BillProviderDropdown<TelevisionProvider>(
                          key: const ValueKey('tv-provider'),
                          fieldKey: const ValueKey('tv-provider-field'),
                          hint: 'Select TV provider',
                          icon: Icons.tv_rounded,
                          asset: AppAssets.television,
                          value: model.televisionProvider,
                          options: TelevisionProvider.values,
                          labelFor: (provider) => provider.label,
                          onChanged: model.selectTelevisionProvider,
                        )
                      else ...[
                        BillProviderDropdown<ElectricityProvider>(
                          key: const ValueKey('electricity-provider'),
                          fieldKey:
                              const ValueKey('electricity-provider-field'),
                          hint: 'Select electricity provider',
                          icon: Icons.lightbulb_outline_rounded,
                          asset: AppAssets.electricity,
                          value: model.electricityProvider,
                          options: ElectricityProvider.values,
                          labelFor: (provider) => provider.label,
                          onChanged: model.selectElectricityProvider,
                        ),
                        const SizedBox(height: 16),
                        _label('Meter Type'),
                        Row(
                            children: ElectricityMeterType.values
                                .map((meterType) => Expanded(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: ChoiceChip(
                                            label: Text(meterType ==
                                                    ElectricityMeterType.prepaid
                                                ? 'Prepaid'
                                                : 'Postpaid'),
                                            selected:
                                                model.meterType == meterType,
                                            selectedColor: AppColors.primary
                                                .withValues(alpha: 0.15),
                                            backgroundColor: AppColors.white,
                                            onSelected: (_) => model
                                                .selectMeterType(meterType),
                                          )),
                                    ))
                                .toList()),
                      ],
                      const SizedBox(height: 16),
                      _label(isTv
                          ? 'Smartcard / IUC Number'
                          : model.meterType == ElectricityMeterType.prepaid
                              ? 'Meter Number'
                              : 'Account Number'),
                      TextFormField(
                        key: ValueKey(
                            isTv ? 'tv-smartcard' : 'electricity-meter'),
                        controller: isTv
                            ? model.smartcardController
                            : model.meterController,
                        validator: isTv
                            ? model.validateSmartcard
                            : model.validateMeter,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(isTv ? 14 : 20)
                        ],
                        decoration: InputDecoration(
                            hintText: isTv
                                ? 'Enter smartcard or IUC number'
                                : 'Enter meter or account number'),
                      ),
                      const SizedBox(height: 16),
                      _label('Phone Number'),
                      TextFormField(
                        key: ValueKey(isTv ? 'tv-phone' : 'electricity-phone'),
                        controller: model.phoneController,
                        validator: model.validatePhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],
                        decoration: const InputDecoration(
                            prefixText: '+234  ',
                            hintText: 'Enter phone number'),
                      ),
                      const SizedBox(height: 16),
                      _label('Payment Method'),
                      BillPaymentMethod(
                          currency: model.currency,
                          onChanged: model.selectCurrency),
                      const SizedBox(height: 20),
                      _label(isTv ? 'Sample Packages' : 'Top Up Amount'),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: isTv
                            ? FormField<TelevisionPackage>(
                                key: ValueKey(model.televisionProvider),
                                initialValue: model.selectedTelevisionPackage,
                                validator: (_) =>
                                    model.selectedTelevisionPackage == null
                                        ? 'Choose a TV package.'
                                        : null,
                                builder: (field) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BillChoiceGrid(
                                        labels: packages
                                            .map((package) => package.name)
                                            .toList(),
                                        details: packages
                                            .map((package) =>
                                                '${money.format(package.priceNaira)}\n${package.validity}')
                                            .toList(),
                                        selectedIndex: packages.indexWhere(
                                            (package) =>
                                                package ==
                                                model
                                                    .selectedTelevisionPackage),
                                        onSelected: (index) {
                                          model.selectTelevisionPackage(
                                              packages[index]);
                                          field.didChange(packages[index]);
                                        },
                                      ),
                                      if (field.hasError)
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(field.errorText!,
                                                style: const TextStyle(
                                                    color:
                                                        AppColors.errorBorder,
                                                    fontSize: 12))),
                                    ]),
                              )
                            : Column(children: [
                                ValueListenableBuilder<TextEditingValue>(
                                  valueListenable:
                                      model.electricityAmountController,
                                  builder: (_, value, __) => BillChoiceGrid(
                                    labels: model.electricityAmounts
                                        .map(money.format)
                                        .toList(),
                                    details: List.filled(
                                        model.electricityAmounts.length,
                                        'Top up'),
                                    selectedIndex: model.electricityAmounts
                                        .indexWhere((amount) =>
                                            amount ==
                                            double.tryParse(value.text)),
                                    onSelected: (index) =>
                                        model.selectElectricityAmount(
                                            model.electricityAmounts[index]),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  key: const ValueKey('electricity-amount'),
                                  controller: model.electricityAmountController,
                                  validator: model.validateElectricityAmount,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]'))
                                  ],
                                  decoration: const InputDecoration(
                                      prefixText: '₦ ',
                                      hintText: '1,000–500,000'),
                                ),
                              ]),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                          height: 54,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.white),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              final form = isTv
                                  ? model.televisionFormKey
                                  : model.electricityFormKey;
                              if (!form.currentState!.validate()) return;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(isTv
                                      ? 'TV payments are not available yet.'
                                      : 'Electricity payments are not available yet.')));
                            },
                            child: Text(
                                isTv ? 'Pay Subscription' : 'Pay Electricity',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          )),
                    ]),
              )),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(fontSize: 14, color: AppColors.darkText)));
}

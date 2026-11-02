import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';
import '../home/widgets/home_top_background.dart';
import 'paybills_viewmodel.dart';
import 'widgets/airtime_network_selector.dart';
import 'widgets/airtime_top_up.dart';

class AirtimeView extends StackedView<PaybillsViewModel> {
  const AirtimeView({super.key, required this.viewModel});
  final PaybillsViewModel viewModel;

  @override
  bool get disposeViewModel => false;

  @override
  Widget builder(
      BuildContext context, PaybillsViewModel viewModel, Widget? child) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.rateTileBorder));
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary, brightness: Brightness.light),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: border,
          enabledBorder: border,
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
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.darkText,
            surfaceTintColor: AppColors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            centerTitle: true,
            title: const Text('Airtime',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            leading: Padding(
              padding: const EdgeInsets.all(9),
              child: IconButton.filledTonal(
                tooltip: 'Back',
                style: IconButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.rateTileBorder),
                    padding: EdgeInsets.zero),
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Form(
              key: viewModel.formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
                children: [
                  AirtimeNetworkSelector(
                      selected: viewModel.network,
                      onChanged: viewModel.selectNetwork),
                  const SizedBox(height: 20),
                  const Text('Phone Number', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: const ValueKey('airtime-phone'),
                    controller: viewModel.phoneController,
                    validator: viewModel.validatePhone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11)
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          ClipOval(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Row(children: [
                                    Expanded(
                                        child: Container(
                                            color: AppColors.nigeriaGreen)),
                                    Expanded(
                                        child:
                                            Container(color: AppColors.white)),
                                    Expanded(
                                        child: Container(
                                            color: AppColors.nigeriaGreen)),
                                  ]))),
                          const SizedBox(width: 6),
                          const Text('+234',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.balanceLabel)),
                          const SizedBox(width: 8),
                          Container(
                              width: 1,
                              height: 24,
                              color: AppColors.rateTileBorder),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(children: [
                    Text('Payment Method', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 6),
                    Tooltip(
                        message:
                            'Choose the stablecoin to use for your airtime payment.',
                        child: Icon(Icons.info,
                            size: 13, color: AppColors.lightIconBorder)),
                  ]),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: AppColors.rateTileBorder)),
                    child: Row(children: [
                      const Expanded(
                          child: Text('Select wallet',
                              style: TextStyle(
                                  color: AppColors.balanceLabel,
                                  fontSize: 13))),
                      Container(
                          width: 1,
                          height: 30,
                          color: AppColors.rateTileBorder),
                      const SizedBox(width: 10),
                      Image.asset(
                          viewModel.currency == 'USDC'
                              ? AppAssets.usdc
                              : AppAssets.usdt,
                          width: 20,
                          height: 20),
                      const SizedBox(width: 6),
                      DropdownButton<String>(
                        value: viewModel.currency,
                        underline: const SizedBox.shrink(),
                        style: const TextStyle(
                            color: AppColors.darkText, fontSize: 12),
                        items: const [
                          DropdownMenuItem(value: 'USDC', child: Text('USDC')),
                          DropdownMenuItem(value: 'USDT', child: Text('USDT'))
                        ],
                        onChanged: viewModel.selectCurrency,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  const Text('Top Up', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  AirtimeTopUp(model: viewModel),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (!viewModel.formKey.currentState!.validate()) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Airtime payments are not available yet.')));
                      },
                      child: const Text('Pay',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PaybillsViewModel viewModelBuilder(BuildContext context) => viewModel;
}

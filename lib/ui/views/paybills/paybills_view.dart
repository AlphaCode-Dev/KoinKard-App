import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'paybills_viewmodel.dart';
import '../home/widgets/home_top_background.dart';
import 'widgets/bill_option.dart';
import 'airtime_view.dart';
import 'tv_view.dart';
import 'electricity_view.dart';

class PaybillsView extends StackedView<PaybillsViewModel> {
  const PaybillsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PaybillsViewModel viewModel,
    Widget? child,
  ) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: HomeTopBackground(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            foregroundColor: AppColors.darkText,
            surfaceTintColor: AppColors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            leading: IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text('Select bill',
                style: AppTextStyles.headingXSmall.copyWith(
                  color: AppColors.darkText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
              children: [
                BillOption(
                    label: 'Electricity',
                    asset: AppAssets.electricity,
                    onTap: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (_) =>
                                ElectricityView(viewModel: viewModel)))),
                BillOption(
                    label: 'TV',
                    asset: AppAssets.television,
                    onTap: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (_) => TvView(viewModel: viewModel)))),
                for (final network in AirtimeNetwork.values)
                  BillOption(
                    label: network.label,
                    asset: network.asset,
                    onTap: () {
                      viewModel.selectNetwork(network);
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (_) => AirtimeView(viewModel: viewModel)),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PaybillsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaybillsViewModel();
}

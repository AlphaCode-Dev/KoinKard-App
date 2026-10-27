import 'package:flutter/material.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'deposit_viewmodel.dart';

class DepositView extends StackedView<DepositViewModel> {
  const DepositView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DepositViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Text('DepositView', style: AppTextStyles.bodyMedium),
        ),
      ),
    );
  }

  @override
  DepositViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DepositViewModel();
}

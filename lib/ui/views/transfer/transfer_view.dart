import 'package:flutter/material.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'transfer_viewmodel.dart';

class TransferView extends StackedView<TransferViewModel> {
  const TransferView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TransferViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Text('TransferView', style: AppTextStyles.bodyMedium),
        ),
      ),
    );
  }

  @override
  TransferViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TransferViewModel();
}

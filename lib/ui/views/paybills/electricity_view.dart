import 'package:flutter/material.dart';
import 'paybills_viewmodel.dart';
import 'utility_bill_view.dart';

class ElectricityView extends StatelessWidget {
  const ElectricityView({super.key, required this.viewModel});
  final PaybillsViewModel viewModel;

  @override
  Widget build(BuildContext context) =>
      UtilityBillView(viewModel: viewModel, type: UtilityBillType.electricity);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'virtual_card_viewmodel.dart';
import 'widgets/virtual_card_actions.dart';
import 'widgets/virtual_card_overview.dart';
import 'widgets/virtual_card_benefits_carousel.dart';
import 'widgets/virtual_card_settings.dart';
import 'widgets/card_password_sheet.dart';
import '../home/widgets/home_top_background.dart';

class VirtualCardView extends StackedView<VirtualCardViewModel> {
  const VirtualCardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    VirtualCardViewModel viewModel,
    Widget? child,
  ) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.kcDarkGreyColor,
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: HomeTopBackground(
              key: ValueKey('virtual-card-upper-panel'),
              padding: EdgeInsets.zero,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: VirtualCardOverview(
                model: viewModel,
                actions: VirtualCardActions(
                  padding: EdgeInsets.zero,
                  onDetails: () =>
                      _protectedAction(context, viewModel, terminating: false),
                  onTransactions: () => _showTransactions(context),
                  onTerminate: () =>
                      _protectedAction(context, viewModel, terminating: true),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: VirtualCardBenefitsCarousel(
              key: ValueKey('virtual-card-benefits-loop'),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: HomeTopBackground(
              key: ValueKey('virtual-card-lower-panel'),
              padding: EdgeInsets.zero,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              child: VirtualCardSettings(model: viewModel),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  VirtualCardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      VirtualCardViewModel();

  Future<void> _protectedAction(
      BuildContext context, VirtualCardViewModel model,
      {required bool terminating}) async {
    final verified = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.homeHeaderSurface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (_) => CardPasswordSheet(model: model, terminating: terminating),
    );
    if (verified != true || !context.mounted) return;
    if (terminating) {
      final confirm = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
                backgroundColor: AppColors.white,
                title: const Text('Terminate this card?',
                    style: TextStyle(color: AppColors.darkText)),
                content: const Text(
                    'Terminating an issued card permanently closes it. This cannot be undone.',
                    style: TextStyle(color: AppColors.balanceLabel)),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text('Cancel')),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppColors.destructive),
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('Terminate card')),
                ],
              ));
      if (confirm != true || !context.mounted) return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(terminating
            ? 'Card termination is not available yet.'
            : 'Issued card details are not available yet.')));
  }

  void _showTransactions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.homeHeaderSurface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (_) => const SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 28),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transactions',
                  style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 16),
              Text('Your card transactions will appear here.',
                  style: TextStyle(color: AppColors.balanceLabel)),
            ]),
      )),
    );
  }
}

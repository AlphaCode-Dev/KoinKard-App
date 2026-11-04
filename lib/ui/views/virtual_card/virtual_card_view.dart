import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'virtual_card_viewmodel.dart';
import 'widgets/virtual_card_actions.dart';
import 'widgets/virtual_card_overview.dart';
import 'widgets/virtual_card_benefits_carousel.dart';
import '../transfer/transfer_view.dart';
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
        body: Column(children: [
          Expanded(
            flex: 11,
            child: HomeTopBackground(
              key: ValueKey('virtual-card-upper-panel'),
              padding: EdgeInsets.zero,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: VirtualCardOverview(
                model: viewModel,
                actions: VirtualCardActions(
                  padding: EdgeInsets.zero,
                  onSend: () => Navigator.of(context).push<void>(
                      MaterialPageRoute(builder: (_) => const TransferView())),
                  onReceive: () => _showFundingNotice(context),
                  onAdd: () => _showFundingNotice(context),
                  onClose: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
          ),
          const VirtualCardBenefitsCarousel(),
          const Expanded(
            flex: 10,
            child: HomeTopBackground(
              key: ValueKey('virtual-card-lower-panel'),
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: SizedBox.expand(),
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

  void _showFundingNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Virtual card funding is not available yet.'),
    ));
  }
}

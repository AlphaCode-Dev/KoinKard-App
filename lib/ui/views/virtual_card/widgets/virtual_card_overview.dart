import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import '../virtual_card_viewmodel.dart';
import 'virtual_card_face.dart';

class VirtualCardOverview extends StatelessWidget {
  const VirtualCardOverview(
      {super.key, required this.model, required this.actions});
  final VirtualCardViewModel model;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(children: [
          Expanded(
            child: LayoutBuilder(
                builder: (_, constraints) => Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Expanded(
                                    child: Text('Virtual Card',
                                        style: TextStyle(
                                            color: AppColors.darkText,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5))),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.lightIconBorder),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text('PREVIEW',
                                        style: TextStyle(
                                            color: AppColors.balanceLabel,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.4))),
                              ]),
                              const SizedBox(height: 20),
                              VirtualCardFace(
                                  number: model.maskedNumber,
                                  cardholder: model.cardholder,
                                  expiry: model.expiry),
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
          const SizedBox(height: 14),
          actions,
        ]),
      ),
    );
  }
}

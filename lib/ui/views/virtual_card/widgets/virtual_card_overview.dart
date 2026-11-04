import 'package:flutter/material.dart';
import 'virtual_card_header.dart';
import '../virtual_card_viewmodel.dart';
import 'virtual_card_face.dart';

class VirtualCardOverview extends StatelessWidget {
  const VirtualCardOverview(
      {super.key, required this.model, required this.actions});
  final VirtualCardViewModel model;
  final Widget actions;

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const VirtualCardHeader(),
            const SizedBox(height: 20),
            VirtualCardFace(
                number: model.maskedNumber,
                cardholder: model.cardholder,
                expiry: model.expiry),
            const SizedBox(height: 14),
            actions,
          ]),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  static const actions = [
    ('Invite', Icons.group_add_rounded),
    ('Cards', Icons.credit_card_rounded),
    ('Bills', Icons.receipt_long_rounded),
    ('More', Icons.more_horiz_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 18,
        crossAxisSpacing: 14,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {
        final item = actions[index];
        return QuickActionItem(
          label: item.$1,
          icon: item.$2,
        );
      },
    );
  }
}

class QuickActionItem extends StatelessWidget {
  const QuickActionItem({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF17191D),
          ),
          child: Icon(
            icon,
            color: kWhiteColor,
            size: 28,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.paragraphSmall.copyWith(
            color: kWhiteColor,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

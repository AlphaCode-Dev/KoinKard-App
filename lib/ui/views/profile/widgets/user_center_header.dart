import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class UserCenterHeader extends StatelessWidget {
  const UserCenterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.arrow_back_rounded,
          color: kWhiteColor,
          size: 28,
        ),
        const Spacer(),
        Text(
          'User Center',
          style: AppTextStyles.headingXSmall.copyWith(
            color: kWhiteColor,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.dark_mode_outlined,
          color: kWhiteColor,
          size: 27,
        ),
        const SizedBox(width: 18),
        Icon(
          Icons.language_rounded,
          color: kWhiteColor,
          size: 29,
        ),
      ],
    );
  }
}

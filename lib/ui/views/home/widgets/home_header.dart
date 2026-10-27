import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _ProfileAvatar(),
        SizedBox(width: 12),
        Expanded(child: _SearchBar()),
        SizedBox(width: 12),
        HeaderIcon(icon: Icons.qr_code_scanner_rounded),
        SizedBox(width: 10),
        HeaderIcon(icon: Icons.card_giftcard_rounded),
        SizedBox(width: 10),
        HeaderIcon(icon: Icons.notifications_none_rounded, badge: '12'),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
        border:
            Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipOval(
          child: Image.asset(
            AppAssets.appicon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.headerGradientStart,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: AppColors.textPrimary.withValues(alpha: 0.76),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'BTC/USDT ',
                    style: AppTextStyles.paragraphMedium.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.94),
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: AppColors.primary.withValues(alpha: 0.95),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' Markets',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.42),
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    super.key,
    required this.icon,
    this.badge,
  });

  final IconData icon;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.headerGradientStart,
          ),
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: 22,
          ),
        ),
        if (badge != null)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.negative,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badge!,
                style: AppTextStyles.labelXSmallBold
                    .copyWith(color: AppColors.white),
              ),
            ),
          ),
      ],
    );
  }
}

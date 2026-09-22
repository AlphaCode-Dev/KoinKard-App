import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

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
        color: const Color(0xFF17181C),
        border: Border.all(color: kWhiteColor.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipOval(
          child: Image.asset(
            AppAssets.kklogo,
            fit: BoxFit.cover,
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
        color: const Color(0xFF15171B),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: kWhiteColor.withValues(alpha: 0.76),
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
                      color: kWhiteColor.withValues(alpha: 0.94),
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: kOrangeColor.withValues(alpha: 0.95),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' Markets',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: kWhiteColor.withValues(alpha: 0.42),
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
            color: const Color(0xFF15171B),
          ),
          child: Icon(
            icon,
            color: kWhiteColor,
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
                color: const Color(0xFFFF4D6D),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badge!,
                style: AppTextStyles.labelXSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

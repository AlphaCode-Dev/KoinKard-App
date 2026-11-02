import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/local/profile_image_service.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import '../receipts/receipts_view.dart';
import '../transfer/transfer_view.dart';
import '../giftcard/giftcard_view.dart';
import 'widgets/home_top_background.dart';
import 'widgets/popular_cards_section.dart';
import 'widgets/home_services_section.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key, this.onSeeAllCards});

  final VoidCallback? onSeeAllCards;

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopBackground(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HomeTopBar(viewModel: viewModel),
                    const SizedBox(height: 26),
                    Text(
                      viewModel.balanceLabel,
                      style: AppTextStyles.paragraphLarge.copyWith(
                        color: AppColors.balanceLabel,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              viewModel.balanceVisible
                                  ? viewModel.balance
                                  : '••••••••',
                              style: AppTextStyles.balanceDisplay.copyWith(
                                  color: AppColors.background,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _RoundIconButton(
                          icon: viewModel.balanceVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 46,
                          tooltip: viewModel.balanceVisible
                              ? 'Hide balance'
                              : 'Show balance',
                          onTap: viewModel.toggleBalanceVisibility,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          viewModel.balanceVisible
                              ? viewModel.profit
                              : '••••••',
                          style: AppTextStyles.paragraphMedium.copyWith(
                            color: AppColors.profitText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_drop_up_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        Text(
                          viewModel.profitPercent,
                          style: AppTextStyles.paragraphMediumBold
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: viewModel.quickActions
                          .map(
                            (action) => Expanded(
                              child: _QuickActionCard(
                                action: action,
                                onTap: action.label == 'Transfer'
                                    ? () => Navigator.of(context).push<void>(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const TransferView()),
                                        )
                                    : null,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeServicesSection(),
                    const SizedBox(height: 24),
                    const _SectionHeader(
                      title: 'Popular Crypto',
                      actionLabel: 'See all',
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: List.generate(viewModel.cryptoShortcuts.length,
                          (index) {
                        final shortcut = viewModel.cryptoShortcuts[index];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right:
                                  index == viewModel.cryptoShortcuts.length - 1
                                      ? 0
                                      : 10,
                            ),
                            child: _CryptoShortcutItem(shortcut: shortcut),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 26),
                    PopularCardsSection(
                      cards: viewModel.popularCards,
                      onSeeAll: onSeeAllCards ??
                          () => Navigator.of(context).push<void>(
                                MaterialPageRoute(
                                  builder: (_) => const GiftcardView(),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final profileImageService = locator<ProfileImageService>();

    return Row(
      children: [
        AnimatedBuilder(
          animation: profileImageService,
          builder: (context, _) => ClipOval(
            child: Container(
              width: 56,
              height: 56,
              color: AppColors.background,
              padding: EdgeInsets.all(
                profileImageService.imagePath == null ? 6 : 0,
              ),
              child: _HomeProfileImage(
                imagePath: profileImageService.imagePath,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.greeting,
                style: AppTextStyles.paragraphSmall.copyWith(
                  color: AppColors.greetingText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                viewModel.userName,
                style: AppTextStyles.paragraphLargeBold
                    .copyWith(color: AppColors.headingOnLight),
              ),
            ],
          ),
        ),
        _RoundIconButton(
          icon: Icons.receipt_long_rounded,
          size: 54,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const ReceiptsView()),
          ),
        ),
        const SizedBox(width: 10),
        const _RoundIconButton(
          icon: Icons.notifications_none_rounded,
          size: 54,
          showDot: true,
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.size,
    this.showDot = false,
    this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final double size;
  final bool showDot;
  final VoidCallback? onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.headingOnLight.withValues(alpha: 0.04),
            ),
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: AppColors.iconOnLight, size: size * 0.42),
            tooltip: tooltip ??
                (icon == Icons.receipt_long_rounded ? 'Receipts' : null),
          ),
        ),
        if (showDot)
          Positioned(
            right: 14,
            top: 13,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.notificationDot,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.action, this.onTap});

  final DashboardAction action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: action.highlighted
                  ? AppColors.primary
                  : AppColors.navigationSurface,
            ),
            child: Icon(
              action.icon,
              color: action.highlighted
                  ? AppColors.background
                  : AppColors.textPrimary,
              size: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.quickActionLabel.copyWith(
                color: AppColors.actionText,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.sectionHeading.copyWith(
          color: AppColors.white, fontSize: 17, fontWeight: FontWeight.w600),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
  });

  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SectionTitle(title: title)),
        Text(
          actionLabel,
          style: AppTextStyles.paragraphSmallBold
              .copyWith(color: AppColors.primary, fontSize: 12),
        ),
      ],
    );
  }
}

class _CryptoShortcutItem extends StatelessWidget {
  const _CryptoShortcutItem({required this.shortcut});

  final CryptoShortcut shortcut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: ClipOval(
            child: Image.asset(
              shortcut.imageAsset,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          shortcut.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.paragraphSmall.copyWith(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _HomeProfileImage extends StatelessWidget {
  const _HomeProfileImage({required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      return Image.asset(
        AppAssets.appicon,
        fit: BoxFit.contain,
      );
    }

    if (kIsWeb) {
      return Image.network(
        imagePath!,
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(imagePath!),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        AppAssets.appicon,
        fit: BoxFit.contain,
      ),
    );
  }
}

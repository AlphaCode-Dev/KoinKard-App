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
import 'widgets/home_top_background.dart';
import 'widgets/popular_cards_section.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.homeGradientTop,
                AppColors.homeGradientMiddle,
                AppColors.background,
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBackground(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HomeTopBar(viewModel: viewModel),
                      const SizedBox(height: 28),
                      Text(
                        viewModel.balanceLabel,
                        style: AppTextStyles.paragraphLarge.copyWith(
                          color: AppColors.balanceLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              viewModel.balance,
                              style: AppTextStyles.balanceDisplay
                                  .copyWith(color: AppColors.balanceText),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const _RoundIconButton(
                            icon: Icons.remove_red_eye_outlined,
                            size: 48,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            viewModel.profit,
                            style: AppTextStyles.paragraphMedium.copyWith(
                              color: AppColors.profitText,
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
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
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
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionHeader(
                        title: 'Popular Crypto',
                        actionLabel: 'See all',
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: List.generate(
                            viewModel.cryptoShortcuts.length, (index) {
                          final shortcut = viewModel.cryptoShortcuts[index];
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index ==
                                        viewModel.cryptoShortcuts.length - 1
                                    ? 0
                                    : 10,
                              ),
                              child: _CryptoShortcutItem(shortcut: shortcut),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 30),
                      PopularCardsSection(cards: viewModel.popularCards),
                    ],
                  ),
                ),
              ],
            ),
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
  });

  final IconData icon;
  final double size;
  final bool showDot;
  final VoidCallback? onTap;

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
              color: AppColors.lightIconBorder,
            ),
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: AppColors.iconOnLight, size: size * 0.42),
            tooltip: icon == Icons.receipt_long_rounded ? 'Receipts' : null,
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
                  : AppColors.actionSurface,
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
            style: AppTextStyles.quickActionLabel
                .copyWith(color: AppColors.actionText),
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
      style:
          AppTextStyles.sectionHeading.copyWith(color: AppColors.textPrimary),
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
              .copyWith(color: AppColors.primary),
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
          style: AppTextStyles.paragraphSmall
              .copyWith(color: AppColors.textPrimary),
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

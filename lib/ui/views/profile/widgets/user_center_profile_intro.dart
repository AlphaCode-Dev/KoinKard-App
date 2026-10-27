import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class UserCenterProfileIntro extends StatelessWidget {
  const UserCenterProfileIntro({
    super.key,
    required this.profileImagePath,
    required this.onProfileImageTap,
  });

  final String? profileImagePath;
  final VoidCallback onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onProfileImageTap,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.background,
                      border: Border.all(
                        color: AppColors.textPrimary.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(profileImagePath == null ? 10 : 0),
                      child: ClipOval(
                        child: _ProfileImage(imagePath: profileImagePath),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.background, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AlphaCode',
                    style: AppTextStyles.profileName
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.textPrimary.withValues(alpha: 0.08),
                    ),
                    child: Text(
                      'Site: KoinKard Global',
                      style: AppTextStyles.labelXSmall.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.78),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppColors.profileProtectionSurface,
            border: Border.all(
                color: AppColors.textPrimary.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: AppColors.background.withValues(alpha: 0.32),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'KoinKard Protect',
                    style: AppTextStyles.compactHeading
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.textPrimary.withValues(alpha: 0.76),
                    size: 19,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Add an anti-phishing code to your KoinKard emails and SMS messages to help detect spoofing attempts.',
                style: AppTextStyles.compactDescription.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.46)),
              ),
              const SizedBox(height: 10),
              Text(
                'Set up anti-phishing code ->',
                style: AppTextStyles.paragraphSmall
                    .copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.imagePath});

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

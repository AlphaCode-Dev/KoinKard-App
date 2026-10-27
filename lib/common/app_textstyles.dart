import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koinkard/common/app_colors.dart';

class AppTextStyles {
  /// Heading
  static TextStyle get headingLarge => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
      );

  static TextStyle get headingMedium => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28.sp,
      );

  static TextStyle get headingSmall => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
      );

  static TextStyle get headingXSmall => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      );

  static TextStyle get buttonInput => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15.sp,
      );

  /// Paragraph
  static TextStyle get paragraphLarge => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      );

  static TextStyle get paragraphMedium => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      );

  static TextStyle get paragraphSmall => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      );

  static TextStyle get paragraphXSmall => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );

  /// Label
  static TextStyle get labelXSmall => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      );

  static TextStyle get titleMedium => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      );

  static const String fontFamily = 'Manrope';

  // Shared component typography. Views only supply context-specific colors.
  static TextStyle bottomNavLabel({required bool selected}) =>
      labelXSmall.copyWith(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 11);
  static TextStyle get balanceDisplay =>
      headingLarge.copyWith(fontSize: 46, height: 1, letterSpacing: -1.4);
  static TextStyle get paragraphMediumBold =>
      paragraphMedium.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get paragraphLargeBold =>
      paragraphLarge.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get quickActionLabel =>
      paragraphMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 14);
  static TextStyle get sectionHeading => headingXSmall.copyWith(fontSize: 20);
  static TextStyle get paragraphSmallBold =>
      paragraphSmall.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get labelXSmallBold =>
      labelXSmall.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get pageHeading => headingMedium.copyWith(fontSize: 28);
  static TextStyle get paragraphMediumMedium =>
      paragraphMedium.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get tabHeading => headingXSmall.copyWith(fontSize: 16);
  static TextStyle get paragraphSmallMedium =>
      paragraphSmall.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get compactHeading => headingXSmall.copyWith(fontSize: 17);
  static TextStyle get smallCardHeading => headingSmall.copyWith(fontSize: 22);
  static TextStyle tradeTab({required bool active}) => paragraphLarge.copyWith(
      fontWeight: active ? FontWeight.w700 : FontWeight.w600);
  static TextStyle get accountStat => headingXSmall.copyWith(fontSize: 21);
  static TextStyle get cardHeading => headingXSmall.copyWith(fontSize: 22);
  static TextStyle get preferenceDescription =>
      bodyMedium.copyWith(height: 1.5);
  static TextStyle get sectionDescription => bodyMedium.copyWith(height: 1.55);
  static TextStyle get profileRowTitle =>
      headingXSmall.copyWith(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle get profileName => headingMedium.copyWith(fontSize: 24);
  static TextStyle get compactDescription => bodyMedium.copyWith(height: 1.4);
  static TextStyle profileTab({required bool active}) => paragraphLarge
      .copyWith(fontWeight: active ? FontWeight.w700 : FontWeight.w500);
  static TextStyle get onboardingHeading => headingLarge.copyWith(height: 1.12);
  static TextStyle get bodyDescription => bodyMedium.copyWith(height: 1.65);
  static TextStyle get walletBalance => headingLarge.copyWith(fontSize: 42);
  static TextStyle marketTab({required bool active}) => paragraphMedium
      .copyWith(fontWeight: active ? FontWeight.w700 : FontWeight.w500);
  static TextStyle get promoTitle => paragraphLarge.copyWith(height: 1.4);
  static TextStyle get quickActionDescription =>
      paragraphSmall.copyWith(height: 1.3);
  static TextStyle get benefitLabel => labelXSmall.copyWith(height: 1.4);
  static TextStyle get giftcardHeading => headingMedium.copyWith(fontSize: 30);
  static TextStyle get giftcardHeroHeading =>
      headingXSmall.copyWith(fontSize: 23, height: 1.25);
  static TextStyle get bodyMessage => bodyMedium.copyWith(height: 1.6);
  static TextStyle get ratesBalance =>
      headingLarge.copyWith(fontSize: 42, height: 1);
  static TextStyle get rateSymbol =>
      headingXSmall.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle get rateValue =>
      headingXSmall.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  static TextStyle get dialogTitle => titleMedium.copyWith(fontSize: 20.sp);
  static TextStyle get authDescription => bodyMedium.copyWith(height: 1.7);
  static TextStyle get loginDescription => paragraphSmall.copyWith(height: 1.6);
  static TextStyle loginTab({required bool selected}) => paragraphSmall
      .copyWith(fontWeight: selected ? FontWeight.w700 : FontWeight.w500);
  static const TextStyle noticeTitle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w900);
  static const TextStyle noticeDescription =
      TextStyle(fontSize: 14, color: AppColors.primary);
  static const TextStyle startupTitle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.w900);
  static const TextStyle startupMessage = TextStyle(fontSize: 16);
  static const TextStyle legalLink =
      TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600);
  static const TextStyle socialMark =
      TextStyle(color: AppColors.background, fontWeight: FontWeight.w700);
  static const TextStyle statusMessage =
      TextStyle(color: AppColors.textPrimary, height: 1.6);
  static const TextStyle retryAction =
      TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700);

  static const TextStyle rateBadge =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1);
  static TextStyle get buttonLabel =>
      paragraphMedium.copyWith(letterSpacing: 1);
  static TextStyle coinLabel({required double size, Color? color}) => TextStyle(
        color: color ?? AppColors.primary,
        fontSize: size * 0.24,
        fontWeight: FontWeight.w800,
      );
}

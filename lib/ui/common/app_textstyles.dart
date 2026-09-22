import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  /// Heading
  static TextStyle headingLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32.sp,
  );

  static TextStyle headingMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28.sp,
  );

  static TextStyle headingSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
  );

  static TextStyle headingXSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );

  static TextStyle buttonInput = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 15.sp,
  );

  /// Paragraph
  static TextStyle paragraphLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  static TextStyle paragraphMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle paragraphSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );

  static TextStyle paragraphXSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp, // ⚠️ FIXED (was 19.sp, too large)
  );

  /// Label
  static TextStyle labelXSmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  /// ✅ ADD THESE

  static TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );

  static TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
}

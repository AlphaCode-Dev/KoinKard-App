import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koinkard/ui/common/app_colors.dart';

class KoinkardPrimaryButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;
  final String? icon;
  final bool isLoading;
  final VoidCallback? onTap;

  const KoinkardPrimaryButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
    this.icon,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? kOrangeColor,
          disabledBackgroundColor:
              disabledBackgroundColor ?? kOrangeColor.withValues(alpha: 0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            else
              Text(
                text,
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: textColor ?? Colors.white,
                ),
              ),
            if (!isLoading && icon != null) ...[
              SizedBox(width: 8.w),
              SvgPicture.asset(
                icon!,
                height: 20.h,
                width: 20.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

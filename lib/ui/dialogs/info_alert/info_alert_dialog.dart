import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  const InfoAlertDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    final title = request.title?.trim().isNotEmpty == true
        ? request.title!.trim()
        : 'Notice';
    final description = request.description?.trim().isNotEmpty == true
        ? request.description!.trim()
        : 'Something happened. Please try again.';
    final isError = viewModel.isErrorTone(title, description);

    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.authSurface,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(
            color: AppColors.textPrimary.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.background.withValues(alpha: 0.35),
              blurRadius: 32,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: isError
                        ? AppColors.errorSurface
                        : AppColors.primary.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: isError
                          ? AppColors.errorBorder
                          : AppColors.primary.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Icon(
                    isError ? Icons.error_outline_rounded : Icons.info_outline,
                    color: isError ? AppColors.errorText : AppColors.primary,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.dialogTitle
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        description,
                        style: AppTextStyles.bodyMessage.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.72)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => completer(DialogResponse(confirmed: true)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
                child: Text(
                  isError ? 'Try Again' : 'Continue',
                  style: AppTextStyles.paragraphMediumBold
                      .copyWith(color: AppColors.background),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) {
    return InfoAlertDialogModel();
  }
}

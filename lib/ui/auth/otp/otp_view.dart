import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:koinkard/ui/widgets/commons/koinkardotpfield.dart';
import 'package:stacked/stacked.dart';

import 'otp_viewmodel.dart';

class OtpView extends StackedView<OtpViewModel> {
  const OtpView({super.key});

  @override
  Widget builder(
    BuildContext context,
    OtpViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const RegisterBrandHeader(),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.authSurface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 26, 28, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.textPrimary,
                              size: 28,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: viewModel.goToLogin,
                            child: Text(
                              'Back to Login',
                              style: AppTextStyles.paragraphSmallMedium
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Enter verification code',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We sent a 6-digit code to your email or mobile number. Enter it below to continue with your KoinKard account.',
                        style: AppTextStyles.authDescription.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.68)),
                      ),
                      const SizedBox(height: 30),
                      KoinkardOtpField(
                        label: 'Verification Code',
                        autofocus: true,
                        fillColor: AppColors.inputSurface,
                        borderColor: AppColors.transparent,
                        activeBorderColor: AppColors.primary,
                        onChanged: viewModel.updateOtp,
                        onCompleted: viewModel.updateOtp,
                      ),
                      const SizedBox(height: 28),
                      KoinkardPrimaryButton(
                        text: 'Verify Code',
                        height: 66,
                        textColor: AppColors.textPrimary,
                        onTap: viewModel.otpCode.length == 6 ? () {} : null,
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 66,
                        child: OutlinedButton(
                          onPressed: viewModel.resendCode,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color:
                                  AppColors.textPrimary.withValues(alpha: 0.18),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            'Resend Code',
                            style: AppTextStyles.paragraphMedium
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Text(
                              'Didn\'t get the code?',
                              style: AppTextStyles.paragraphSmall.copyWith(
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.52),
                              ),
                            ),
                            TextButton(
                              onPressed: viewModel.resendCode,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                              ),
                              child: Text(
                                'Send Again',
                                style: AppTextStyles.paragraphMediumBold
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  OtpViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpViewModel();
}

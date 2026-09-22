import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
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
      backgroundColor: kDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const RegisterBrandHeader(),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF0D0F0F),
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
                              color: kWhiteColor,
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
                              style: AppTextStyles.paragraphSmall.copyWith(
                                color: kOrangeColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Enter verification code',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We sent a 6-digit code to your email or mobile number. Enter it below to continue with your KoinKard account.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.68),
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 30),
                      KoinkardOtpField(
                        label: 'Verification Code',
                        autofocus: true,
                        fillColor: const Color(0xFF1A1B22),
                        borderColor: Colors.transparent,
                        activeBorderColor: kOrangeColor,
                        onChanged: viewModel.updateOtp,
                        onCompleted: viewModel.updateOtp,
                      ),
                      const SizedBox(height: 28),
                      KoinkardPrimaryButton(
                        text: 'Verify Code',
                        height: 66,
                        textColor: kWhiteColor,
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
                              color: kWhiteColor.withValues(alpha: 0.18),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            'Resend Code',
                            style: AppTextStyles.paragraphMedium.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
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
                                color: kWhiteColor.withValues(alpha: 0.52),
                              ),
                            ),
                            TextButton(
                              onPressed: viewModel.resendCode,
                              style: TextButton.styleFrom(
                                foregroundColor: kOrangeColor,
                              ),
                              child: Text(
                                'Send Again',
                                style: AppTextStyles.paragraphMedium.copyWith(
                                  color: kOrangeColor,
                                  fontWeight: FontWeight.w700,
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

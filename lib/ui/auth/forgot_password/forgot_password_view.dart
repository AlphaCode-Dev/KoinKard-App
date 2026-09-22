import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:koinkard/ui/widgets/commons/koinkardinputfield.dart';
import 'package:stacked/stacked.dart';

import 'forgot_password_viewmodel.dart';

class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> {
  const ForgotPasswordView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
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
                        'Forgot your password?',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Enter the email address or mobile number linked to your KoinKard account and we will help you reset access.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.68),
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 30),
                      KoinkardInputField(
                        controller: viewModel.identifierController,
                        label: 'Email/Mobile Number',
                        hintText: 'Enter your email or phone number',
                        keyboardType: TextInputType.emailAddress,
                        fillColor: const Color(0xFF1A1B22),
                        borderColor: Colors.transparent,
                        prefixIcon: const Icon(
                          Icons.lock_reset_rounded,
                          color: kWhiteColor,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 28),
                      KoinkardPrimaryButton(
                        text: 'Send Reset Link',
                        height: 66,
                        textColor: kWhiteColor,
                        onTap: () {},
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 66,
                        child: OutlinedButton(
                          onPressed: viewModel.goToLogin,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: kWhiteColor.withValues(alpha: 0.18),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            'Return to Login',
                            style: AppTextStyles.paragraphMedium.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
  ForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotPasswordViewModel();
}

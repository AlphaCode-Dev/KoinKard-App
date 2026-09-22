import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/login/widgets/login_method_toggle.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:koinkard/ui/widgets/commons/koinkardinputfield.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
                            onPressed: viewModel.goToRegister,
                            child: Text(
                              'Sign Up',
                              style: AppTextStyles.paragraphSmall.copyWith(
                                color: kOrangeColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      LoginMethodToggle(
                        isEmailSelected: viewModel.isEmailSelected,
                        onSelectEmail: viewModel.selectEmail,
                        onSelectPhone: viewModel.selectPhone,
                      ),
                      const SizedBox(height: 26),
                      KoinkardInputField(
                        controller: viewModel.identifierController,
                        hintText: viewModel.isEmailSelected
                            ? 'Enter your email address'
                            : 'Enter mobile number',
                        keyboardType: viewModel.isEmailSelected
                            ? TextInputType.emailAddress
                            : TextInputType.phone,
                        fillColor: const Color(0xFF1A1B22),
                        borderColor: Colors.transparent,
                        prefixIcon: Icon(
                          viewModel.isEmailSelected
                              ? Icons.mail_outline_rounded
                              : Icons.phone_iphone_rounded,
                          color: kWhiteColor,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 34),
                      KoinkardPrimaryButton(
                        text: 'Next',
                        height: 66,
                        textColor: kDarkColor,
                        onTap: viewModel.goToHome,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 66,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: kWhiteColor.withValues(alpha: 0.18),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            'Continue with Passkey',
                            style: AppTextStyles.paragraphMedium.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 34),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            TextButton(
                              onPressed: viewModel.goToForgotPassword,
                              style: TextButton.styleFrom(
                                foregroundColor: kWhiteColor,
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: AppTextStyles.paragraphMedium.copyWith(
                                  color: kWhiteColor.withValues(alpha: 0.84),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '|',
                              style: AppTextStyles.paragraphMedium.copyWith(
                                color: kWhiteColor.withValues(alpha: 0.20),
                              ),
                            ),
                            TextButton(
                              onPressed: viewModel.goToRegister,
                              style: TextButton.styleFrom(
                                foregroundColor: kOrangeColor,
                              ),
                              child: Text(
                                'Create Account',
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
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}

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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  child: Form(
                    key: viewModel.formKey,
                    autovalidateMode: viewModel.hasAttemptedSubmit
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
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
                        const SizedBox(height: 22),
                        Text(
                          'Welcome back to KoinKard',
                          style: AppTextStyles.headingSmall.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sign in with the email address or phone number linked to your account.',
                          style: AppTextStyles.paragraphSmall.copyWith(
                            color: kWhiteColor.withValues(alpha: 0.52),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 28),
                        LoginMethodToggle(
                          isEmailSelected: viewModel.isEmailSelected,
                          onSelectEmail: viewModel.selectEmail,
                          onSelectPhone: viewModel.selectPhone,
                        ),
                        const SizedBox(height: 18),
                        KoinkardInputField(
                          controller: viewModel.identifierController,
                          hintText: viewModel.isEmailSelected
                              ? 'Enter your email address'
                              : 'Enter your phone number',
                          keyboardType: viewModel.isEmailSelected
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: viewModel.validateIdentifier,
                          fillColor: const Color(0xFF1A1B22),
                          borderColor: Colors.transparent,
                          onChanged: viewModel.onFieldChanged,
                          helperText: viewModel.isEmailSelected
                              ? 'Log in with your email address.'
                              : 'Log in with your phone number.',
                          prefixIcon: Icon(
                            viewModel.isEmailSelected
                                ? Icons.mail_outline_rounded
                                : Icons.phone_iphone_rounded,
                            color: kWhiteColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 18),
                        KoinkardInputField(
                          controller: viewModel.passwordController,
                          hintText: 'Enter your password',
                          textInputAction: TextInputAction.done,
                          validator: viewModel.validatePassword,
                          obscureText: true,
                          fillColor: const Color(0xFF1A1B22),
                          borderColor: Colors.transparent,
                          onChanged: viewModel.onFieldChanged,
                          onFieldSubmitted: (_) => viewModel.login(),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: kWhiteColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 34),
                        KoinkardPrimaryButton(
                          text: 'Login',
                          height: 66,
                          textColor: kDarkColor,
                          isLoading: viewModel.isBusy,
                          onTap: viewModel.canSubmit ? viewModel.login : null,
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

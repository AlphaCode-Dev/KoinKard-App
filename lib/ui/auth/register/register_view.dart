import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/login/widgets/login_method_toggle.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:koinkard/ui/widgets/commons/koinkardinputfield.dart';
import 'package:stacked/stacked.dart';

import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  padding: const EdgeInsets.fromLTRB(28, 26, 28, 28),
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
                                'Login Now',
                                style: AppTextStyles.paragraphSmallMedium
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Create a KoinKard account',
                          style: AppTextStyles.headingSmall.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Use your real details so we can create and secure your account properly.',
                          style: AppTextStyles.loginDescription.copyWith(
                              color: AppColors.textPrimary
                                  .withValues(alpha: 0.52)),
                        ),
                        const SizedBox(height: 28),
                        KoinkardInputField(
                          controller: viewModel.fullNameController,
                          label: 'Full Name',
                          hintText: 'Enter your full name',
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: viewModel.validateFullName,
                          onChanged: viewModel.onFieldChanged,
                          fillColor: AppColors.inputSurface,
                          borderColor: AppColors.transparent,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.textPrimary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 18),
                        LoginMethodToggle(
                          isEmailSelected: viewModel.isEmailSelected,
                          onSelectEmail: viewModel.selectEmail,
                          onSelectPhone: viewModel.selectPhone,
                        ),
                        const SizedBox(height: 18),
                        KoinkardInputField(
                          controller: viewModel.isEmailSelected
                              ? viewModel.emailController
                              : viewModel.phoneController,
                          hintText: viewModel.isEmailSelected
                              ? 'Enter your email address'
                              : 'Enter your phone number',
                          keyboardType: viewModel.isEmailSelected
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: viewModel.isEmailSelected
                              ? viewModel.validateEmail
                              : viewModel.validatePhone,
                          onChanged: viewModel.onFieldChanged,
                          fillColor: AppColors.inputSurface,
                          borderColor: AppColors.transparent,
                          helperText: viewModel.isEmailSelected
                              ? 'Register with your email address.'
                              : 'Register with your phone number.',
                          prefixIcon: Icon(
                            viewModel.isEmailSelected
                                ? Icons.mail_outline_rounded
                                : Icons.phone_iphone_rounded,
                            color: AppColors.textPrimary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 18),
                        KoinkardInputField(
                          controller: viewModel.passwordController,
                          label: 'Password',
                          hintText: 'Create a secure password',
                          textInputAction: TextInputAction.done,
                          validator: viewModel.validatePassword,
                          onChanged: viewModel.onFieldChanged,
                          onFieldSubmitted: (_) => viewModel.register(),
                          obscureText: true,
                          fillColor: AppColors.inputSurface,
                          borderColor: AppColors.transparent,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.textPrimary,
                            size: 22,
                          ),
                          helperText: 'Use at least 12 characters.',
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: viewModel.toggleTerms,
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: viewModel.acceptedTerms,
                                  onChanged: (_) => viewModel.toggleTerms(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.textPrimary
                                        .withValues(alpha: 0.56),
                                  ),
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.selected)
                                            ? AppColors.textPrimary
                                            : AppColors.transparent,
                                  ),
                                  checkColor: AppColors.background,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RichText(
                                      text: TextSpan(
                                        style: AppTextStyles.bodyDescription
                                            .copyWith(
                                                color: AppColors.textPrimary
                                                    .withValues(
                                          alpha: 0.62,
                                        )),
                                        children: const [
                                          TextSpan(
                                            text:
                                                'I have read and agree to the KoinKard ',
                                          ),
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: AppTextStyles.legalLink,
                                          ),
                                          TextSpan(text: ' & '),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: AppTextStyles.legalLink,
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
                        const SizedBox(height: 18),
                        KoinkardPrimaryButton(
                          text: 'Create Account',
                          height: 66,
                          textColor: AppColors.background,
                          isLoading: viewModel.isBusy,
                          onTap:
                              viewModel.canSubmit ? viewModel.register : null,
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
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}

import 'package:flutter/material.dart';
import 'package:koinkard/ui/auth/login/widgets/login_method_toggle.dart';
import 'package:koinkard/ui/auth/register/widgets/register_brand_header.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
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
                                'Login Now',
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
                          'Create a KoinKard account',
                          style: AppTextStyles.headingSmall.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Use your real details so we can create and secure your account properly.',
                          style: AppTextStyles.paragraphSmall.copyWith(
                            color: kWhiteColor.withValues(alpha: 0.52),
                            height: 1.6,
                          ),
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
                          fillColor: const Color(0xFF1A1B22),
                          borderColor: Colors.transparent,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: kWhiteColor,
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
                          fillColor: const Color(0xFF1A1B22),
                          borderColor: Colors.transparent,
                          helperText: viewModel.isEmailSelected
                              ? 'Register with your email address.'
                              : 'Register with your phone number.',
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
                          label: 'Password',
                          hintText: 'Create a secure password',
                          textInputAction: TextInputAction.done,
                          validator: viewModel.validatePassword,
                          onChanged: viewModel.onFieldChanged,
                          onFieldSubmitted: (_) => viewModel.register(),
                          obscureText: true,
                          fillColor: const Color(0xFF1A1B22),
                          borderColor: Colors.transparent,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: kWhiteColor,
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
                                    color: kWhiteColor.withValues(alpha: 0.56),
                                  ),
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.selected)
                                            ? kWhiteColor
                                            : Colors.transparent,
                                  ),
                                  checkColor: kDarkColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          color: kWhiteColor.withValues(
                                            alpha: 0.62,
                                          ),
                                          height: 1.65,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text:
                                                'I have read and agree to the KoinKard ',
                                          ),
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: TextStyle(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' & '),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w600,
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
                        const SizedBox(height: 18),
                        KoinkardPrimaryButton(
                          text: 'Create Account',
                          height: 66,
                          textColor: kDarkColor,
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

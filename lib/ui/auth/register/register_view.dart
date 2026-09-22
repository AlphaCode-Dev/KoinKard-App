import 'package:flutter/material.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                      const SizedBox(height: 26),
                      Text(
                        'Create a KoinKard account',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.public,
                            color: kWhiteColor.withValues(alpha: 0.42),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'KoinKard Global',
                            style: AppTextStyles.paragraphSmall.copyWith(
                              color: kWhiteColor.withValues(alpha: 0.42),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      KoinkardInputField(
                        controller: viewModel.emailController,
                        label: 'Email/Mobile Number',
                        hintText: 'Enter email/phone (without code)',
                        keyboardType: TextInputType.emailAddress,
                        fillColor: const Color(0xFF1A1B22),
                        borderColor: Colors.transparent,
                      ),
                      const SizedBox(height: 18),
                      KoinkardInputField(
                        controller: viewModel.referralController,
                        label: 'Referral Code (Optional)',
                        hintText: 'Enter referral code',
                        fillColor: const Color(0xFF1A1B22),
                        borderColor: Colors.transparent,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: kWhiteColor.withValues(alpha: 0.46),
                        ),
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
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color:
                                            kWhiteColor.withValues(alpha: 0.62),
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
                        text: 'Sign Up Now',
                        height: 66,
                        textColor: kWhiteColor,
                        onTap: viewModel.acceptedTerms ? () {} : null,
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
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}

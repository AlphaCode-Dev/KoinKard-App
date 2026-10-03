import 'package:flutter/material.dart';
import 'package:koinkard/app/app.dialogs.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:koinkard/data/models/register/register_request_model.dart';
import 'package:koinkard/data/services/register/register_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _registerService = locator<RegisterService>();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool acceptedTerms = true;
  bool hasAttemptedSubmit = false;
  bool isEmailSelected = true;

  bool get canSubmit =>
      acceptedTerms &&
      !isBusy &&
      fullNameController.text.trim().isNotEmpty &&
      activeContactValue.isNotEmpty &&
      passwordController.text.isNotEmpty;

  String get activeContactValue => isEmailSelected
      ? emailController.text.trim()
      : phoneController.text.trim();

  void toggleTerms() {
    acceptedTerms = !acceptedTerms;
    rebuildUi();
  }

  void selectEmail() {
    if (isEmailSelected) return;
    isEmailSelected = true;
    phoneController.clear();
    rebuildUi();
  }

  void selectPhone() {
    if (!isEmailSelected) return;
    isEmailSelected = false;
    emailController.clear();
    rebuildUi();
  }

  void onFieldChanged(String _) {
    rebuildUi();
  }

  void goToLogin() {
    _navigationService.navigateToLoginView();
  }

  String? validateFullName(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Full name is required.';
    }
    if (input.length < 3) {
      return 'Enter your full name.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (!isEmailSelected) {
      return null;
    }

    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Email address is required.';
    }

    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(input)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (isEmailSelected) {
      return null;
    }

    final input = value?.replaceAll(' ', '') ?? '';
    if (input.isEmpty) {
      return 'Phone number is required.';
    }

    final phonePattern = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phonePattern.hasMatch(input)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    if (input.length < 12) {
      return 'Password must be at least 12 characters.';
    }
    return null;
  }

  Future<void> register() async {
    hasAttemptedSubmit = true;
    rebuildUi();

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    if (!acceptedTerms) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Accept the terms',
        description:
            'Please agree to the Terms of Service and Privacy Policy to continue.',
      );
      return;
    }

    setBusy(true);

    final result = await _registerService.register(
      RegisterRequestModel(
        fullName: fullNameController.text.trim(),
        email: isEmailSelected ? emailController.text.trim() : '',
        phone: isEmailSelected ? '' : phoneController.text.trim(),
        password: passwordController.text,
      ),
    );

    setBusy(false);

    if (result.isFailure || result.data == null) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Registration failed',
        description:
            result.message ?? 'We could not create your account right now.',
      );
      return;
    }

    await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Account created',
      description: result.data!.message,
    );
    await _navigationService.replaceWithLoginView();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

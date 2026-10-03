import 'package:flutter/material.dart';
import 'package:koinkard/app/app.dialogs.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:koinkard/data/models/login/login_request_model.dart';
import 'package:koinkard/data/models/login/login_response_model.dart';
import 'package:koinkard/data/services/login/login_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _loginService = locator<LoginService>();

  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailSelected = true;
  bool hasAttemptedSubmit = false;

  bool get canSubmit =>
      !isBusy &&
      identifierController.text.trim().isNotEmpty &&
      passwordController.text.isNotEmpty;

  void selectEmail() {
    if (isEmailSelected) return;
    isEmailSelected = true;
    identifierController.clear();
    rebuildUi();
  }

  void selectPhone() {
    if (!isEmailSelected) return;
    isEmailSelected = false;
    identifierController.clear();
    rebuildUi();
  }

  void onFieldChanged(String _) {
    rebuildUi();
  }

  void goToRegister() {
    _navigationService.replaceWithRegisterView();
  }

  void goToForgotPassword() {
    _navigationService.navigateToForgotPasswordView();
  }

  String? validateIdentifier(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return isEmailSelected
          ? 'Email address is required.'
          : 'Phone number is required.';
    }

    if (isEmailSelected) {
      final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      if (!emailPattern.hasMatch(input)) {
        return 'Enter a valid email address.';
      }
      return null;
    }

    final normalizedPhone = input.replaceAll(' ', '');
    final phonePattern = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phonePattern.hasMatch(normalizedPhone)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  Future<void> login() async {
    hasAttemptedSubmit = true;
    rebuildUi();

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setBusy(true);

    final result = await _loginService.login(
      LoginRequestModel(
        identifier: identifierController.text.trim(),
        password: passwordController.text,
      ),
    );

    setBusy(false);

    if (result.isFailure || result.data == null) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Login failed',
        description: result.message ?? 'We could not sign you in right now.',
      );
      return;
    }

    final response = result.data!;

    if (response.requiresTwoFactor) {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Two-factor required',
        description: _buildTwoFactorMessage(response),
      );
      return;
    }

    await _navigationService.replaceWithBottomnavbarView();
  }

  String _buildTwoFactorMessage(LoginResponseModel response) {
    final buffer = StringBuffer(response.message);

    if (response.user.email.isNotEmpty) {
      buffer.write('\n\nCheck ${response.user.email} for your sign-in code.');
    }

    if (response.demoCode.isNotEmpty) {
      buffer.write('\n\nDemo code: ${response.demoCode}');
    }

    return buffer.toString();
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

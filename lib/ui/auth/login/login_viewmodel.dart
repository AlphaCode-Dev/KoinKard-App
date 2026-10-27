import 'package:flutter/material.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailSelected = true;
  bool hasAttemptedSubmit = false;

  bool get canSubmit => !isBusy;

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
    return null;
  }

  String? validatePassword(String? value) {
    return null;
  }

  Future<void> login() async {
    // Authentication is temporarily bypassed for the UI preview.
    // final isValid = formKey.currentState?.validate() ?? false;
    // if (!isValid) return;
    // final result = await _loginService.login(LoginRequestModel(
    //   identifier: identifierController.text.trim(),
    //   password: passwordController.text,
    // ));
    await _navigationService.replaceWithBottomnavbarView();
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

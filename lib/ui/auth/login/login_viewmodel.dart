import 'package:flutter/material.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final identifierController = TextEditingController(
    text: 'adebanjiakinsole@gmail.com',
  );

  bool isEmailSelected = true;

  void selectEmail() {
    if (isEmailSelected) return;
    isEmailSelected = true;
    rebuildUi();
  }

  void selectPhone() {
    if (!isEmailSelected) return;
    isEmailSelected = false;
    rebuildUi();
  }

  void goToRegister() {
    _navigationService.replaceWithRegisterView();
  }

  void goToForgotPassword() {
    _navigationService.navigateToForgotPasswordView();
  }

  void goToHome() {
    _navigationService.replaceWithBottomnavbarView();
  }

  @override
  void dispose() {
    identifierController.dispose();
    super.dispose();
  }
}

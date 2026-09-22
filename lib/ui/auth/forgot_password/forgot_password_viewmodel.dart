import 'package:flutter/material.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final identifierController = TextEditingController();

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }

  @override
  void dispose() {
    identifierController.dispose();
    super.dispose();
  }
}

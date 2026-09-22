import 'package:flutter/material.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final emailController = TextEditingController();
  final referralController = TextEditingController();

  bool acceptedTerms = true;

  void toggleTerms() {
    acceptedTerms = !acceptedTerms;
    rebuildUi();
  }

  void goToLogin() {
    _navigationService.navigateToLoginView();
  }

  @override
  void dispose() {
    emailController.dispose();
    referralController.dispose();
    super.dispose();
  }
}

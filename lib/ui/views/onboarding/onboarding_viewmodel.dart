import 'package:flutter/material.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel();

  final _navigationService = locator<NavigationService>();
  final PageController pageController = PageController();

  Future<void> nextPage() async {
    if (!pageController.hasClients) return;

    await pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void completeOnboarding() {
    _navigationService.replaceWithRegisterView();
  }

  void skipOnboarding() {
    _navigationService.replaceWithRegisterView();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigationService.replaceWithOnboardingView();
  }
}

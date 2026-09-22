import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String otpCode = '';

  void updateOtp(String value) {
    otpCode = value;
    rebuildUi();
  }

  void goToLogin() {
    _navigationService.replaceWithLoginView();
  }

  void resendCode() {}
}

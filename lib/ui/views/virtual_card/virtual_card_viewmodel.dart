import 'package:stacked/stacked.dart';

class VirtualCardViewModel extends BaseViewModel {
  VirtualCardViewModel({Future<bool> Function(String)? passwordVerifier})
      : _passwordVerifier = passwordVerifier;
  final Future<bool> Function(String)? _passwordVerifier;

  Future<String?> verifyPassword(String password) async {
    if (password.isEmpty) return 'Enter your account password.';
    final verifier = _passwordVerifier;
    if (verifier == null) return 'Password verification is not available yet.';
    try {
      return await verifier(password)
          ? null
          : 'Incorrect password. Please try again.';
    } catch (_) {
      return 'Unable to verify your password. Please try again.';
    }
  }

  bool _cardUnfrozen = true;
  bool get cardUnfrozen => _cardUnfrozen;

  void setCardUnfrozen(bool value) {
    _cardUnfrozen = value;
    notifyListeners();
  }

  String get maskedNumber => '••••  ••••  ••••  0000';
  String get cardholder => 'YOUR NAME';
  String get expiry => 'MM/YY';
}

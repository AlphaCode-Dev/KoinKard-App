import 'package:koinkard/data/models/login/login_user_model.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.token,
    required this.user,
    required this.requiresTwoFactor,
    required this.challengeToken,
    required this.demoCode,
    required this.message,
  });

  final String token;
  final LoginUserModel user;
  final bool requiresTwoFactor;
  final String challengeToken;
  final String demoCode;
  final String message;

  bool get isAuthenticated => token.isNotEmpty && !requiresTwoFactor;
  bool get hasTwoFactorChallenge =>
      requiresTwoFactor && challengeToken.isNotEmpty;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    final requiresTwoFactor = json['requires_two_factor'] == true;
    final token = (json['token'] ?? '').toString();
    final challengeToken = (json['challenge_token'] ?? '').toString();
    final demoCode = (json['demo_code'] ?? '').toString();

    return LoginResponseModel(
      token: token,
      user: userJson is Map<String, dynamic>
          ? LoginUserModel.fromJson(userJson)
          : const LoginUserModel(
              id: 0,
              fullName: '',
              email: '',
              phone: '',
              status: 'active',
              verificationTier: 0,
              emailVerified: false,
              twoFactorEnabled: false,
            ),
      requiresTwoFactor: requiresTwoFactor,
      challengeToken: challengeToken,
      demoCode: demoCode,
      message: _resolveMessage(
        rawMessage: (json['message'] ?? '').toString(),
        requiresTwoFactor: requiresTwoFactor,
        token: token,
      ),
    );
  }

  static String _resolveMessage({
    required String rawMessage,
    required bool requiresTwoFactor,
    required String token,
  }) {
    if (rawMessage.trim().isNotEmpty) {
      return rawMessage.trim();
    }

    if (requiresTwoFactor) {
      return 'A verification code is required to complete your sign in.';
    }

    if (token.isNotEmpty) {
      return 'Login successful.';
    }

    return 'Login response received.';
  }
}

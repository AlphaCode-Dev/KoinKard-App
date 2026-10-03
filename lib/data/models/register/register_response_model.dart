import 'package:koinkard/data/models/register/register_user_model.dart';

class RegisterResponseModel {
  const RegisterResponseModel({
    required this.token,
    required this.user,
    required this.message,
  });

  final String token;
  final RegisterUserModel user;
  final String message;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    return RegisterResponseModel(
      token: (json['token'] ?? '').toString(),
      user: userJson is Map<String, dynamic>
          ? RegisterUserModel.fromJson(userJson)
          : const RegisterUserModel(
              id: 0,
              fullName: '',
              email: '',
              phone: '',
            ),
      message: (json['message'] ?? 'Account created successfully.').toString(),
    );
  }
}

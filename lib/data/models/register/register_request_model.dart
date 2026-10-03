class RegisterRequestModel {
  const RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{
      'full_name': fullName.trim(),
      'password': password,
    };

    final normalizedEmail = email.trim();
    final normalizedPhone = phone.trim();

    if (normalizedEmail.isNotEmpty) {
      payload['email'] = normalizedEmail;
    }

    if (normalizedPhone.isNotEmpty) {
      payload['phone'] = normalizedPhone;
    }

    return payload;
  }
}

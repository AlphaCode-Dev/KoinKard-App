class LoginUserModel {
  const LoginUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.status,
    required this.verificationTier,
    required this.emailVerified,
    required this.twoFactorEnabled,
    this.createdAt,
  });

  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String status;
  final int verificationTier;
  final bool emailVerified;
  final bool twoFactorEnabled;
  final DateTime? createdAt;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse('${json['id']}') ?? 0,
      fullName: (json['full_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      status: (json['status'] ?? 'active').toString(),
      verificationTier: json['verification_tier'] is int
          ? json['verification_tier'] as int
          : int.tryParse('${json['verification_tier']}') ?? 0,
      emailVerified: json['email_verified'] == true,
      twoFactorEnabled: json['two_factor_enabled'] == true,
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
    );
  }
}

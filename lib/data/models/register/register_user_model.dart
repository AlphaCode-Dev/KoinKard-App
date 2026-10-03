class RegisterUserModel {
  const RegisterUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.status,
    this.verificationTier,
    this.emailVerified,
    this.twoFactorEnabled,
  });

  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String? status;
  final int? verificationTier;
  final bool? emailVerified;
  final bool? twoFactorEnabled;

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      id: _readInt(json['id']),
      fullName: (json['full_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      status: json['status']?.toString(),
      verificationTier: _tryReadInt(json['verification_tier']),
      emailVerified: _tryReadBool(json['email_verified']),
      twoFactorEnabled: _tryReadBool(json['two_factor_enabled']),
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _tryReadInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static bool? _tryReadBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    final normalized = value?.toString().toLowerCase();
    if (normalized == 'true') {
      return true;
    }
    if (normalized == 'false') {
      return false;
    }
    return null;
  }
}

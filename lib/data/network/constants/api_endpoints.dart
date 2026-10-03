class ApiEndpoints {
  const ApiEndpoints._();

  static const String apiV1 = '/api/v1';
  static const String health = '/health';

  static const String auth = '$apiV1/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String forgotPassword = '$auth/forgot-password';
  static const String verifyOtp = '$auth/verify-otp';
  static const String refreshToken = '$auth/refresh-token';

  static const String users = '$apiV1/users';
  static const String profile = '$users/profile';
  static const String account = '$apiV1/account';
  static const String accountCommerce = '$account/commerce';
  static const String accountOrders = '$account/orders';

  static const String wallets = '$apiV1/wallets';
  static const String assets = '$apiV1/assets';
  static const String trades = '$apiV1/trades';
  static const String giftCards = '$apiV1/gift-cards';
}

import 'package:dio/dio.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/local/session_storage_service.dart';
import 'package:koinkard/data/network/config/api_config.dart';
import 'package:koinkard/data/network/interceptors/api_log_interceptor.dart';
import 'package:koinkard/data/network/interceptors/auth_interceptor.dart';
import 'package:koinkard/data/network/services/api_client.dart';
import 'package:koinkard/data/services/giftcard/giftcard_trade_service.dart';
import 'package:koinkard/data/services/login/login_service.dart';
import 'package:koinkard/data/services/register/register_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupApiLocator() async {
  if (!locator.isRegistered<SharedPreferences>()) {
    final preferences = await SharedPreferences.getInstance();
    locator.registerSingleton<SharedPreferences>(preferences);
  }

  if (!locator.isRegistered<SessionStorageService>()) {
    locator.registerLazySingleton<SessionStorageService>(
      () => SessionStorageService(locator<SharedPreferences>()),
    );
  }

  if (!locator.isRegistered<Dio>()) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(locator<SessionStorageService>()),
      ApiLogInterceptor(),
    ]);

    locator.registerSingleton<Dio>(dio);
  }

  if (!locator.isRegistered<ApiClient>()) {
    locator.registerLazySingleton<ApiClient>(
      () => ApiClient(locator<Dio>()),
    );
  }

  if (!locator.isRegistered<RegisterService>()) {
    locator.registerLazySingleton<RegisterService>(
      () => RegisterService(
        locator<ApiClient>(),
        locator<SessionStorageService>(),
      ),
    );
  }

  if (!locator.isRegistered<LoginService>()) {
    locator.registerLazySingleton<LoginService>(
      () => LoginService(
        locator<ApiClient>(),
        locator<SessionStorageService>(),
      ),
    );
  }

  if (!locator.isRegistered<GiftcardTradeService>()) {
    locator.registerLazySingleton<GiftcardTradeService>(
      () => GiftcardTradeService(locator<ApiClient>()),
    );
  }
}

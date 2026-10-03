import 'package:dio/dio.dart';
import 'package:koinkard/data/local/session_storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._sessionStorageService);

  final SessionStorageService _sessionStorageService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = _sessionStorageService.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }
}

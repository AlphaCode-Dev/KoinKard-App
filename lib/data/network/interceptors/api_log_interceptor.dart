import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiLogInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(
        '[API] ${options.method.toUpperCase()} ${options.baseUrl}${options.path}',
      );
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[API][ERROR] ${err.requestOptions.method.toUpperCase()} '
        '${err.requestOptions.path} -> ${err.response?.statusCode ?? 'no-status'}',
      );
    }
    handler.next(err);
  }
}

import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.identifier,
  });

  final String message;
  final int? statusCode;
  final String? identifier;

  factory ApiException.fromDioException(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final responseData = response?.data;

    return ApiException(
      message: _resolveMessage(error, responseData),
      statusCode: statusCode,
      identifier: error.type.name,
    );
  }

  static String _resolveMessage(DioException error, dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final directMessage = _readMessage(responseData);
      if (directMessage != null) {
        return directMessage;
      }
    }

    final baseUrl = error.requestOptions.baseUrl;
    final rawMessage = error.message?.trim() ?? '';

    if (_isCleartextBlocked(rawMessage)) {
      return 'HTTP connections are blocked on this Android build for $baseUrl.'
          ' Allow cleartext traffic for local development or switch the API to HTTPS.';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'The request timed out while contacting $baseUrl.'
            '${_connectionHint(baseUrl)}';
      case DioExceptionType.connectionError:
        return 'Unable to connect to $baseUrl.${_connectionHint(baseUrl)}';
      case DioExceptionType.badCertificate:
        return 'A secure connection could not be established.';
      case DioExceptionType.cancel:
        return 'The request was cancelled.';
      case DioExceptionType.badResponse:
        return 'The server returned an unexpected response.';
      case DioExceptionType.unknown:
        if (rawMessage.isNotEmpty) {
          return 'Request failed: $rawMessage';
        }
        return 'Something went wrong. Please try again.';
    }
  }

  static bool _isCleartextBlocked(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('cleartext') &&
        normalized.contains('not permitted');
  }

  static String? _readMessage(Map<String, dynamic> responseData) {
    final directKeys = ['message', 'error', 'detail'];

    for (final key in directKeys) {
      final value = responseData[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    final detail = responseData['detail'];
    if (detail is List) {
      final parts = detail
          .map(_readDetailItem)
          .whereType<String>()
          .where((item) => item.trim().isNotEmpty)
          .toList();
      if (parts.isNotEmpty) {
        return parts.join('\n');
      }
    }

    return null;
  }

  static String? _readDetailItem(dynamic item) {
    if (item is String) {
      return item.trim();
    }

    if (item is Map<String, dynamic>) {
      final message = item['msg'] ?? item['message'] ?? item['detail'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    }

    return null;
  }

  static String _connectionHint(String baseUrl) {
    if (baseUrl.contains('10.0.2.2')) {
      return ' This Android build is pointing at the emulator host. If you are using a real phone, either run `adb reverse tcp:8000 tcp:8000` and use USB mode, or run the app with `--dart-define=ANDROID_API_MODE=lan --dart-define=ANDROID_LAN_API_HOST=YOUR_PC_IP`.';
    }

    if (baseUrl.contains('localhost') || baseUrl.contains('127.0.0.1')) {
      return ' Make sure the backend server is running on port 8000. For a real Android phone, also run `adb reverse tcp:8000 tcp:8000` before opening the app.';
    }

    return ' Please confirm the API URL is reachable from this device.';
  }

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}

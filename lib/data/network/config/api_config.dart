import 'package:flutter/foundation.dart';

class ApiConfig {
  const ApiConfig._();

  static const String _localBackendUrl = 'http://127.0.0.1:8000';
  static const String _androidUsbReverseBackendUrl = 'http://127.0.0.1:8000';
  static const String _androidEmulatorBackendUrl = 'http://10.0.2.2:8000';

  static const String _apiBaseUrlOverride = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static const String _androidApiMode = String.fromEnvironment(
    'ANDROID_API_MODE',
    defaultValue: 'usb',
  );

  static const String _androidLanApiHost = String.fromEnvironment(
    'ANDROID_LAN_API_HOST',
    defaultValue: '',
  );

  static String get baseUrl {
    if (_apiBaseUrlOverride.isNotEmpty) {
      return _normalizeBaseUrl(_apiBaseUrlOverride);
    }

    if (kIsWeb) return _localBackendUrl;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _resolveAndroidBaseUrl();
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return _localBackendUrl;
      case TargetPlatform.fuchsia:
        return _localBackendUrl;
    }
  }

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static String _resolveAndroidBaseUrl() {
    switch (_androidApiMode.toLowerCase().trim()) {
      case 'emulator':
        return _androidEmulatorBackendUrl;
      case 'lan':
        if (_androidLanApiHost.isNotEmpty) {
          return _buildLanBaseUrl(_androidLanApiHost);
        }
        return _androidUsbReverseBackendUrl;
      case 'usb':
      case 'reverse':
      case 'usb-reverse':
      default:
        return _androidUsbReverseBackendUrl;
    }
  }

  static String _buildLanBaseUrl(String hostOrUrl) {
    final normalized = _normalizeBaseUrl(hostOrUrl);
    if (normalized.startsWith('http://') || normalized.startsWith('https://')) {
      return normalized;
    }
    return 'http://$normalized:8000';
  }

  static String _normalizeBaseUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.endsWith('/')) {
      return trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed;
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageService extends ChangeNotifier {
  ProfileImageService([SharedPreferences? preferences])
      : _preferences = preferences {
    _imagePath = _preferences?.getString(_imagePathKey);
  }

  static const String _imagePathKey = 'profile_image_path';

  final SharedPreferences? _preferences;
  String? _imagePath;

  String? get imagePath => _imagePath;

  Future<void> initialise() async {
    if (kIsWeb || _imagePath == null) return;

    if (!await File(_imagePath!).exists()) {
      await setImagePath(null);
      return;
    }

    // Migrate photos previously saved as temporary image-picker cache paths.
    await setImagePath(_imagePath);
  }

  Future<void> setImagePath(String? value) async {
    String? savedPath = value == null || value.isEmpty ? null : value;
    if (!kIsWeb && savedPath != null) {
      final source = File(savedPath);
      if (await source.exists()) {
        final supportDirectory = await getApplicationSupportDirectory();
        final imageDirectory = Directory(
          '${supportDirectory.path}${Platform.pathSeparator}profile_images',
        );
        await imageDirectory.create(recursive: true);
        if (source.parent.path != imageDirectory.path) {
          final destination = '${imageDirectory.path}${Platform.pathSeparator}'
              '${DateTime.now().microsecondsSinceEpoch}_${source.uri.pathSegments.last}';
          savedPath = (await source.copy(destination)).path;
        }
      } else {
        savedPath = null;
      }
    }

    final changed = _imagePath != savedPath;

    final preferences = _preferences;
    if (preferences != null) {
      if (savedPath == null) {
        await preferences.remove(_imagePathKey);
      } else {
        await preferences.setString(_imagePathKey, savedPath);
      }
    }

    _imagePath = savedPath;
    if (changed) notifyListeners();
  }
}

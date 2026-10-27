import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/data/local/profile_image_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory directory;
  late SharedPreferences preferences;
  const channel = MethodChannel('plugins.flutter.io/path_provider');

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('koinkard_profile_test_');
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'getApplicationSupportDirectory') {
        return '${directory.path}/support';
      }
      return null;
    });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    await directory.delete(recursive: true);
  });

  test('clears a saved photo whose cache file is missing', () async {
    await preferences.setString(
        'profile_image_path', '${directory.path}/gone.jpg');
    final service = ProfileImageService(preferences);
    await service.initialise();
    expect(service.imagePath, isNull);
    expect(preferences.containsKey('profile_image_path'), isFalse);
    service.dispose();
  });

  test('keeps the selected photo after the picker cache file is deleted',
      () async {
    final source =
        await File('${directory.path}/picked.jpg').writeAsBytes([1, 2, 3]);
    final service = ProfileImageService(preferences);
    await service.setImagePath(source.path);
    final savedPath = service.imagePath!;
    expect(savedPath, isNot(source.path));
    await source.delete();
    expect(await File(savedPath).readAsBytes(), [1, 2, 3]);

    final restored = ProfileImageService(preferences);
    await restored.initialise();
    expect(restored.imagePath, savedPath);
    service.dispose();
    restored.dispose();
  });

  test('migrates an existing cache photo to permanent storage at startup',
      () async {
    final source =
        await File('${directory.path}/legacy.jpg').writeAsBytes([4, 5]);
    await preferences.setString('profile_image_path', source.path);
    final service = ProfileImageService(preferences);
    await service.initialise();
    expect(service.imagePath, isNot(source.path));
    expect(preferences.getString('profile_image_path'), service.imagePath);
    expect(await File(service.imagePath!).readAsBytes(), [4, 5]);
    service.dispose();
  });
}

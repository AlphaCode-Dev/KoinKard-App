import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koinkard/app/app.locator.dart';
import 'package:koinkard/data/local/profile_image_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final ImagePicker _imagePicker = ImagePicker();
  final ProfileImageService _profileImageService =
      locator<ProfileImageService>();

  UserCenterTab _activeTab = UserCenterTab.myInfo;
  bool _google2FaEnabled = false;
  bool _isPickingProfileImage = false;

  UserCenterTab get activeTab => _activeTab;
  bool get google2FaEnabled => _google2FaEnabled;
  bool get isPickingProfileImage => _isPickingProfileImage;
  String? get profileImagePath => _profileImageService.imagePath;

  void selectTab(UserCenterTab tab) {
    if (_activeTab == tab) return;
    _activeTab = tab;
    rebuildUi();
  }

  void setGoogle2FaEnabled(bool value) {
    if (_google2FaEnabled == value) return;
    _google2FaEnabled = value;
    rebuildUi();
  }

  Future<void> pickProfileImage() async {
    if (_isPickingProfileImage) return;

    _isPickingProfileImage = true;
    rebuildUi();

    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (file == null) return;

      await _profileImageService.setImagePath(file.path);
    } on PlatformException catch (error) {
      if (error.code != 'already_active') {
        rethrow;
      }
    } finally {
      _isPickingProfileImage = false;
      rebuildUi();
    }
  }
}

enum UserCenterTab { myInfo, security }

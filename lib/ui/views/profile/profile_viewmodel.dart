import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  UserCenterTab _activeTab = UserCenterTab.myInfo;
  bool _google2FaEnabled = false;

  UserCenterTab get activeTab => _activeTab;
  bool get google2FaEnabled => _google2FaEnabled;

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
}

enum UserCenterTab { myInfo, security }

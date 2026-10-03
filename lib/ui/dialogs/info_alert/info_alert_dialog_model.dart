import 'package:stacked/stacked.dart';

class InfoAlertDialogModel extends BaseViewModel {
  bool isErrorTone(String title, String description) {
    final content = '${title.toLowerCase()} ${description.toLowerCase()}';
    return content.contains('error') ||
        content.contains('failed') ||
        content.contains('invalid') ||
        content.contains('unable') ||
        content.contains('try again');
  }
}

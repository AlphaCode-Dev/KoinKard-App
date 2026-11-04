import 'package:stacked/stacked.dart';

class VirtualCardViewModel extends BaseViewModel {
  String get maskedNumber => '••••  ••••  ••••  0000';
  String get cardholder => 'YOUR NAME';
  String get expiry => 'MM/YY';
}

import 'package:koinkard/common/app_assets.dart';

enum AirtimeNetwork {
  mtn('MTN', AppAssets.mtn),
  airtel('Airtel', AppAssets.airtel),
  glo('Glo', AppAssets.glo),
  nineMobile('9mobile', AppAssets.nineMobile);

  const AirtimeNetwork(this.label, this.asset);
  final String label;
  final String asset;
}

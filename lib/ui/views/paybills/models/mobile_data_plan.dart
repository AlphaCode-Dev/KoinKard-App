import 'airtime_network.dart';

class MobileDataPlan {
  const MobileDataPlan({
    required this.id,
    required this.network,
    required this.name,
    required this.validity,
    required this.priceNaira,
    this.enabled = true,
    this.isSample = false,
  });

  final String id;
  final AirtimeNetwork network;
  final String name;
  final String validity;
  final double priceNaira;
  final bool enabled;
  final bool isSample;
}

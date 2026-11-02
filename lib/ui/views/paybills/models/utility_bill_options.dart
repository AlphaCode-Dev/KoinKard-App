enum UtilityBillType { television, electricity }

enum ElectricityMeterType { prepaid, postpaid }

enum TelevisionProvider {
  dstv('DStv'),
  gotv('GOtv'),
  startimes('StarTimes');

  const TelevisionProvider(this.label);
  final String label;
}

enum ElectricityProvider {
  ikeja('Ikeja Electric'),
  eko('Eko Electric'),
  abuja('Abuja Electric'),
  ibadan('Ibadan Electric'),
  portHarcourt('Port Harcourt Electric'),
  kano('Kano Electric');

  const ElectricityProvider(this.label);
  final String label;
}

class TelevisionPackage {
  const TelevisionPackage(
      {required this.id,
      required this.provider,
      required this.name,
      required this.priceNaira,
      this.validity = '30 days'});
  final String id;
  final TelevisionProvider provider;
  final String name;
  final double priceNaira;
  final String validity;
}

// Sample packages for UI preview; no live provider pricing.
final List<TelevisionPackage> sampleTelevisionPackages = List.unmodifiable([
  for (final provider in TelevisionProvider.values)
    for (final package in const [
      (name: 'Basic', price: 2500.0),
      (name: 'Standard', price: 6000.0),
      (name: 'Premium', price: 12000.0),
    ])
      TelevisionPackage(
          id: 'sample-${provider.name}-${package.name}',
          provider: provider,
          name: package.name,
          priceNaira: package.price),
]);

import 'airtime_network.dart';
import 'mobile_data_plan.dart';

// Preview catalog, replaced by updateDataPlans when the provider is connected.
final List<MobileDataPlan> sampleDataPlans = List.unmodifiable([
  for (final network in AirtimeNetwork.values)
    for (final bundle in const [
      (name: '500 MB', validity: '1 day', price: 150.0),
      (name: '1 GB', validity: '7 days', price: 300.0),
      (name: '2 GB', validity: '7 days', price: 600.0),
      (name: '5 GB', validity: '30 days', price: 1500.0),
      (name: '10 GB', validity: '30 days', price: 3000.0),
      (name: '20 GB', validity: '30 days', price: 5000.0),
    ])
      MobileDataPlan(
        id: 'sample-${network.name}-${bundle.name}',
        network: network,
        name: bundle.name,
        validity: bundle.validity,
        priceNaira: bundle.price,
        isSample: true,
      ),
]);

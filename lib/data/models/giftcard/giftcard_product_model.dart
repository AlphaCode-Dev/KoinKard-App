class GiftcardProductModel {
  const GiftcardProductModel({
    required this.id,
    required this.kind,
    required this.name,
    required this.symbol,
    required this.buyRate,
    required this.sellRate,
    required this.paymentDetails,
    required this.instructions,
    required this.enabled,
  });

  final int id;
  final String kind;
  final String name;
  final String symbol;
  final double buyRate;
  final double sellRate;
  final String paymentDetails;
  final String instructions;
  final bool enabled;

  String get brandLabel => name.trim().isEmpty ? 'Gift Card' : name.trim();

  String get countryLabel => symbol.trim().isEmpty ? 'Global' : symbol.trim();

  double get activeRate => buyRate > 0 ? buyRate : sellRate;

  factory GiftcardProductModel.fromJson(Map<String, dynamic> json) {
    return GiftcardProductModel(
      id: _readInt(json['id']),
      kind: (json['kind'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      symbol: (json['symbol'] ?? '').toString(),
      buyRate: _readDouble(json['buy_rate']),
      sellRate: _readDouble(json['sell_rate']),
      paymentDetails: (json['payment_details'] ?? '').toString(),
      instructions: (json['instructions'] ?? '').toString(),
      enabled: json['enabled'] == true || json['enabled'] == 1,
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _readDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

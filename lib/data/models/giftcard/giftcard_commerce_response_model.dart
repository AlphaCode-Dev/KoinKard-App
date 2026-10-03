import 'package:koinkard/data/models/giftcard/giftcard_product_model.dart';

class GiftcardCommerceResponseModel {
  const GiftcardCommerceResponseModel({
    required this.nairaBalance,
    required this.securityCodeEnabled,
    required this.products,
  });

  final String nairaBalance;
  final bool securityCodeEnabled;
  final List<GiftcardProductModel> products;

  List<GiftcardProductModel> get giftcardProducts =>
      products.where((product) => product.kind == 'gift_card').toList();

  factory GiftcardCommerceResponseModel.fromJson(Map<String, dynamic> json) {
    final rawProducts = json['products'];
    return GiftcardCommerceResponseModel(
      nairaBalance: (json['naira_balance'] ?? '0').toString(),
      securityCodeEnabled: json['security_code_enabled'] == true,
      products: rawProducts is List
          ? rawProducts
              .whereType<Map<String, dynamic>>()
              .map(GiftcardProductModel.fromJson)
              .toList()
          : const [],
    );
  }
}

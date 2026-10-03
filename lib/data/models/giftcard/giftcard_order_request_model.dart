class GiftcardOrderRequestModel {
  const GiftcardOrderRequestModel({
    required this.productId,
    required this.amount,
    required this.digitalCode,
    required this.proofReference,
    required this.payoutMethod,
    this.bankAccountId,
  });

  final int productId;
  final String amount;
  final String digitalCode;
  final String proofReference;
  final String payoutMethod;
  final int? bankAccountId;

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{
      'product_id': productId,
      'amount': amount,
      'digital_code': digitalCode.trim(),
      'proof_reference': proofReference.trim(),
      'payout_method': payoutMethod,
    };

    if (bankAccountId != null) {
      payload['bank_account_id'] = bankAccountId;
    }

    return payload;
  }
}

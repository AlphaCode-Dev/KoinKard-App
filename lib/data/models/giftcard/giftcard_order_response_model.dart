class GiftcardOrderResponseModel {
  const GiftcardOrderResponseModel({
    required this.id,
    required this.status,
    required this.payoutNgn,
    required this.amount,
    required this.productId,
    required this.payoutMethod,
    required this.createdAt,
    this.adminNote,
  });

  final int id;
  final String status;
  final String payoutNgn;
  final String amount;
  final int productId;
  final String payoutMethod;
  final String createdAt;
  final String? adminNote;

  factory GiftcardOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return GiftcardOrderResponseModel(
      id: _readInt(json['id']),
      status: (json['status'] ?? '').toString(),
      payoutNgn: (json['payout_ngn'] ?? '0').toString(),
      amount: (json['amount'] ?? '0').toString(),
      productId: _readInt(json['product_id']),
      payoutMethod: (json['payout_method'] ?? 'wallet').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
      adminNote: json['admin_note']?.toString(),
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

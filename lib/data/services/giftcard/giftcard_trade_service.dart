import 'package:dio/dio.dart';
import 'package:koinkard/data/models/api_result.dart';
import 'package:koinkard/data/models/giftcard/giftcard_commerce_response_model.dart';
import 'package:koinkard/data/models/giftcard/giftcard_order_request_model.dart';
import 'package:koinkard/data/models/giftcard/giftcard_order_response_model.dart';
import 'package:koinkard/data/network/constants/api_endpoints.dart';
import 'package:koinkard/data/network/services/api_client.dart';
import 'package:koinkard/data/repositories/base_api_repository.dart';

class GiftcardTradeService extends BaseApiRepository {
  GiftcardTradeService(this._apiClient);

  final ApiClient _apiClient;

  Future<ApiResult<GiftcardCommerceResponseModel>> fetchCommerce() {
    return guardApiCall(() async {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.accountCommerce,
      );
      return GiftcardCommerceResponseModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
    });
  }

  Future<ApiResult<GiftcardOrderResponseModel>> createOrder(
    GiftcardOrderRequestModel request,
  ) {
    return guardApiCall(() async {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.accountOrders,
        data: request.toJson(),
        options: Options(
          headers: {
            'Idempotency-Key':
                'giftcard-${request.productId}-${DateTime.now().microsecondsSinceEpoch}',
          },
        ),
      );
      return GiftcardOrderResponseModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
    });
  }
}

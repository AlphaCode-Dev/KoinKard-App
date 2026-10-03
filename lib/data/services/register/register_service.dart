import 'package:koinkard/data/local/session_storage_service.dart';
import 'package:koinkard/data/models/api_result.dart';
import 'package:koinkard/data/models/register/register_request_model.dart';
import 'package:koinkard/data/models/register/register_response_model.dart';
import 'package:koinkard/data/network/constants/api_endpoints.dart';
import 'package:koinkard/data/network/services/api_client.dart';
import 'package:koinkard/data/repositories/base_api_repository.dart';

class RegisterService extends BaseApiRepository {
  RegisterService(this._apiClient, this._sessionStorageService);

  final ApiClient _apiClient;
  final SessionStorageService _sessionStorageService;

  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) {
    return guardApiCall(() async {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      final responseData = response.data ?? <String, dynamic>{};
      final registerResponse = RegisterResponseModel.fromJson(responseData);

      await _persistSession(registerResponse);
      return registerResponse;
    });
  }

  Future<void> _persistSession(RegisterResponseModel response) async {
    if (response.token.isNotEmpty) {
      await _sessionStorageService.saveAccessToken(response.token);
    }

    if (response.user.id > 0) {
      await _sessionStorageService.saveUserId(response.user.id.toString());
    }
  }
}

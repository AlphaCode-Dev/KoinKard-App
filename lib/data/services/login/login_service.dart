import 'package:koinkard/data/local/session_storage_service.dart';
import 'package:koinkard/data/models/api_result.dart';
import 'package:koinkard/data/models/login/login_request_model.dart';
import 'package:koinkard/data/models/login/login_response_model.dart';
import 'package:koinkard/data/network/constants/api_endpoints.dart';
import 'package:koinkard/data/network/services/api_client.dart';
import 'package:koinkard/data/repositories/base_api_repository.dart';

class LoginService extends BaseApiRepository {
  LoginService(this._apiClient, this._sessionStorageService);

  final ApiClient _apiClient;
  final SessionStorageService _sessionStorageService;

  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) {
    return guardApiCall(() async {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final responseData = response.data ?? <String, dynamic>{};
      final loginResponse = LoginResponseModel.fromJson(responseData);

      await _persistSession(loginResponse);
      return loginResponse;
    });
  }

  Future<void> _persistSession(LoginResponseModel response) async {
    if (!response.isAuthenticated) {
      return;
    }

    await _sessionStorageService.clearSession();

    await _sessionStorageService.saveAccessToken(response.token);

    if (response.user.id > 0) {
      await _sessionStorageService.saveUserId(response.user.id.toString());
    }
  }
}

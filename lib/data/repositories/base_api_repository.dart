import 'package:koinkard/data/models/api_result.dart';
import 'package:koinkard/data/network/exceptions/api_exception.dart';

abstract class BaseApiRepository {
  Future<ApiResult<T>> guardApiCall<T>(Future<T> Function() action) async {
    try {
      final data = await action();
      return ApiResult.success(data);
    } on ApiException catch (error) {
      return ApiResult.failure(
        message: error.message,
        statusCode: error.statusCode,
      );
    } catch (_) {
      return ApiResult.failure(
        message: 'Something went wrong. Please try again.',
      );
    }
  }
}

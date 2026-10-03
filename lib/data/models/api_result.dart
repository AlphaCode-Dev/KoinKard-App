class ApiResult<T> {
  const ApiResult._({
    this.data,
    this.message,
    this.statusCode,
    required this.isSuccess,
  });

  final T? data;
  final String? message;
  final int? statusCode;
  final bool isSuccess;

  bool get isFailure => !isSuccess;

  factory ApiResult.success(T data, {int? statusCode, String? message}) {
    return ApiResult._(
      data: data,
      statusCode: statusCode,
      message: message,
      isSuccess: true,
    );
  }

  factory ApiResult.failure({String? message, int? statusCode}) {
    return ApiResult._(
      message: message,
      statusCode: statusCode,
      isSuccess: false,
    );
  }
}

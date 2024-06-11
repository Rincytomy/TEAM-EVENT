import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  late String message;

  ApiExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }
  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? error['error'] ?? error['data'] ?? 'Bad request';
      case 401:
        return error['message'] ?? error['error'] ?? error['data'] ?? 'Unauthorized';
      case 403:
        return error['message'] ?? error['error'] ?? error['data'] ?? 'Forbidden';
      // return 'Forbidden';
      case 404:
        return error['message'] ?? 'Not found';
      case 422:
        return error['message'] ?? 'Unprocessable entity';
      case 500:
        return error['message'] ?? 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

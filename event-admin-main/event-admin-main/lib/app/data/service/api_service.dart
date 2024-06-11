import 'package:dio/dio.dart';

import '../../constants/app_url.dart';
import 'box_service.dart';
import 'logging.interceptor.dart';

class ApiInterfaces {
  ApiInterfaces() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${token()}';
        return handler.next(options);
      },
    ));
  }

  static final options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.json,
    contentType: 'application/json',
  );

  final Dio _dio = Dio(options)..interceptors.add(LoggingInterceptor());

  String token() {
    final box = BoxService();
    return box.token;
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

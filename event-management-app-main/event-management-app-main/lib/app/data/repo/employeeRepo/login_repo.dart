import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../../service/api_service.dart';
import '../../service/logging.interceptor.dart';

class LoginRepo {
  final Dio _dio = Dio(ApiInterfaces.options)
    ..interceptors.add(LoggingInterceptor());

  Future<Response> login(
      {required String email, required String password}) async {
    try {
      final data = {'email': email, 'password': password};
      final response = await _dio.post(AppUrl.login, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(dynamic data) async {
    try {
      final response = await _dio.post(AppUrl.register, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

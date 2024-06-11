import 'package:dio/dio.dart';
import 'package:event_management_admin/app/constants/app_url.dart';
import 'package:event_management_admin/app/data/service/api_service.dart';

import '../service/logging.interceptor.dart';

class LoginRepo {
  final Dio _dio = Dio(ApiInterfaces.options)..interceptors.add(LoggingInterceptor());

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        AppUrl.login,
        data: {'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
